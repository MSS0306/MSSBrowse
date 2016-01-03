//
//  JDYBrowseViewController.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/23.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "JDYBrowseViewController.h"
#import "JDYBrowseCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIImage+JDYScale.h"
#import "JDYBrowseDefine.h"

@interface JDYBrowseViewController ()

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *browseItemArray;
@property (nonatomic,assign)BOOL isFirstOpen;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)BOOL isRotate;// 判断是否正在切换横竖屏

@end

@implementation JDYBrowseViewController

- (id)initWithBrowseItemArray:(NSArray *)browseItemArray currentIndex:(NSInteger)currentIndex
{
    self = [super init];
    if(self)
    {
        _browseItemArray = browseItemArray;
        _currentIndex = currentIndex;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBrowseView];
}

- (void)createBrowseView
{
    // 电池条方向改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusBarOrientationDidChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    self.view.backgroundColor = [UIColor clearColor];
    _isFirstOpen = YES;
    [self createCollectionView];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    // 布局方式改为从上至下，默认从左到右
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // Section Inset就是某个section中cell的边界范围
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 每行内部cell item的间距
    flowLayout.minimumInteritemSpacing = 0;
    // 每行的间距
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor blackColor];
    [_collectionView registerClass:[JDYBrowseCollectionViewCell class] forCellWithReuseIdentifier:@"Browser_Cell"];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(kBrowseSpace);
    }];
    [_collectionView layoutIfNeeded];
    _collectionView.contentOffset = CGPointMake(_currentIndex * (JDY_SCREEN_WIDTH + kBrowseSpace), 0);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark UIColectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JDYBrowseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Browser_Cell" forIndexPath:indexPath];
    if(cell)
    {
        // 停止加载
        [cell.loadingView stopAnimation];
        
        JDYBrowseModel *browseItem = [_browseItemArray objectAtIndex:indexPath.row];
        // 还原初始缩放比例
        cell.zoomScrollView.zoomScale = 1.0f;
        // 将scrollview的contentSize还原成缩放前
        cell.zoomScrollView.contentSize = CGSizeMake(JDY_SCREEN_WIDTH, JDY_SCREEN_HEIGHT);
        cell.zoomScrollView.zoomImageView.contentMode = browseItem.smallImageView.contentMode;
        cell.zoomScrollView.zoomImageView.clipsToBounds = browseItem.smallImageView.clipsToBounds;
        // 判断大图是否存在
        if([[SDImageCache sharedImageCache]diskImageExistsWithKey:browseItem.bigImageUrl])
        {
            // 显示大图
            [self showBigImage:cell.zoomScrollView.zoomImageView browseItem:browseItem];
        }
        // 如果大图不存在
        else
        {
            // 加载大图
            [self loadBigImage:cell.zoomScrollView.zoomImageView browseItem:browseItem cell:cell];
        }
        
        __weak __typeof(self)weakSelf = self;
        [cell tapClick:^(JDYBrowseCollectionViewCell *browseCell) {
            [weakSelf tap:browseCell];
        }];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _browseItemArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JDY_SCREEN_WIDTH + kBrowseSpace, JDY_SCREEN_HEIGHT);
}

- (void)showBigImage:(UIImageView *)imageView browseItem:(JDYBrowseModel *)browseItem
{
    // 如果存在直接显示
    [imageView sd_setImageWithURL:[NSURL URLWithString:browseItem.bigImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize size = [image jdy_getSizeAfterFit];
        // 第一次打开浏览页需要加载动画
        if(_isFirstOpen)
        {
            _isFirstOpen = NO;
            imageView.frame = [self getFrameInWindow:browseItem.smallImageView];
            [UIView animateWithDuration:0.5 animations:^{
                imageView.frame = CGRectMake((JDY_SCREEN_WIDTH - size.width) / 2, (JDY_SCREEN_HEIGHT - size.height) / 2, size.width, size.height);
            }];
        }
        else
        {
            imageView.frame = CGRectMake((JDY_SCREEN_WIDTH - size.width) / 2, (JDY_SCREEN_HEIGHT - size.height) / 2, size.width, size.height);
        }
    }];
}

// 加载大图
- (void)loadBigImage:(UIImageView *)imageView browseItem:(JDYBrowseModel *)browseItem cell:(JDYBrowseCollectionViewCell *)cell
{
    // 加载圆圈显示
    [cell.loadingView startAnimation];
    // 默认为屏幕中间
    imageView.frame = CGRectMake((self.view.jdyWidth - browseItem.smallImageView.jdyWidth) / 2, (self.view.jdyHeight - browseItem.smallImageView.jdyHeight) / 2, browseItem.smallImageView.jdyWidth, browseItem.smallImageView.jdyHeight);

    [imageView sd_setImageWithURL:[NSURL URLWithString:browseItem.bigImageUrl] placeholderImage:browseItem.smallImageView.image options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 此处可做图片加载进度
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 关闭图片浏览view的时候，不需要继续执行小图加载大图动画
        if(_collectionView.userInteractionEnabled)
        {
            // 停止加载
            [cell.loadingView stopAnimation];
            if(error)
            {
                NSLog(@"图片加载失败");
            }
            else
            {
                CGSize size = [image jdy_getSizeAfterFit];
                // 图片加载成功
                [UIView animateWithDuration:0.5 animations:^{
                    cell.zoomScrollView.zoomImageView.frame = CGRectMake((JDY_SCREEN_WIDTH - size.width) / 2, (JDY_SCREEN_HEIGHT - size.height) / 2, size.width, size.height);
                }];
            }
        }
    }];
}

#pragma mark UIScrollViewDeletate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!_isRotate)
    {
        _currentIndex = scrollView.contentOffset.x / (JDY_SCREEN_WIDTH + kBrowseSpace);
    }
    _isRotate = NO;
}

- (void)tap:(JDYBrowseCollectionViewCell *)browseCell
{
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 点击时移除通知，避免多执行一次通知方法
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    // 集合视图背景色设置为透明
    _collectionView.backgroundColor = [UIColor clearColor];
    // 动画结束前不可点击透明背景后的内容
    _collectionView.userInteractionEnabled = NO;
    // 停止加载
    NSArray *cellArray = _collectionView.visibleCells;
    for (JDYBrowseCollectionViewCell *cell in cellArray)
    {
        [cell.loadingView stopAnimation];
    }
    NSIndexPath *indexPath = [_collectionView indexPathForCell:browseCell];
    browseCell.zoomScrollView.zoomScale = 1.0f;
    JDYBrowseModel *browseItem = _browseItemArray[indexPath.row];
    CGRect rect = [self getFrameInWindow:browseItem.smallImageView];
    [UIView animateWithDuration:0.5 animations:^{
        browseCell.zoomScrollView.zoomImageView.frame = rect;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view
{
    // 改用[UIApplication sharedApplication].keyWindow.rootViewController.view，防止present新viewController坐标转换不准问题
    return [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

#pragma mark Orientation Method
- (void)statusBarOrientationDidChange:(NSNotification *)notification
{
    _isRotate = YES;
    [_collectionView layoutIfNeeded];
    _collectionView.contentOffset = CGPointMake(_currentIndex * (JDY_SCREEN_WIDTH + kBrowseSpace), 0);
    [_collectionView reloadData];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
