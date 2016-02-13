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
@property (nonatomic,strong)UILabel *countLabel;// 当前图片位置
@property (nonatomic,assign)CGFloat screenWidth;
@property (nonatomic,assign)CGFloat screenHeight;
@property (nonatomic,strong)UIView *snapshotView;
@property (nonatomic,strong)NSMutableArray *verticalBigRectArray;
@property (nonatomic,strong)NSMutableArray *horizontalBigRectArray;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,assign)UIDeviceOrientation currentOrientation;

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

- (void)showBrowseViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    _snapshotView = [rootViewController.view snapshotViewAfterScreenUpdates:NO];
    [rootViewController presentViewController:self animated:NO completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createBrowseView];
}

- (void)initData
{
    _isFirstOpen = YES;
    _screenWidth = JDY_SCREEN_WIDTH;
    _screenHeight = JDY_SCREEN_HEIGHT;
    _currentOrientation = UIDeviceOrientationPortrait;
    _verticalBigRectArray = [[NSMutableArray alloc]init];
    _horizontalBigRectArray = [[NSMutableArray alloc]init];
    for (JDYBrowseModel *browseItem in _browseItemArray)
    {
        CGRect verticalRect = [browseItem.smallImageView.image jdy_getBigImageRectSizeWithScreenWidth:JDY_SCREEN_WIDTH screenHeight:JDY_SCREEN_HEIGHT];
        NSValue *verticalValue = [NSValue valueWithCGRect:verticalRect];
        [_verticalBigRectArray addObject:verticalValue];
        
        CGRect horizontalRect = [browseItem.smallImageView.image jdy_getBigImageRectSizeWithScreenWidth:JDY_SCREEN_HEIGHT screenHeight:JDY_SCREEN_WIDTH];
        NSValue *horizontalValue = [NSValue valueWithCGRect:horizontalRect];
        [_horizontalBigRectArray addObject:horizontalValue];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view
{
    // 改用[UIApplication sharedApplication].keyWindow.rootViewController.view，防止present新viewController坐标转换不准问题
    return [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

- (void)createBrowseView
{
    self.view.backgroundColor = [UIColor blackColor];
    _snapshotView.hidden = YES;
    [self.view addSubview:_snapshotView];
    
    _bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
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
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _screenWidth + kBrowseSpace, _screenHeight) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor blackColor];
    [_collectionView registerClass:[JDYBrowseCollectionViewCell class] forCellWithReuseIdentifier:@"JDYBrowserCell"];
    _collectionView.contentOffset = CGPointMake(_currentIndex * (_screenWidth + kBrowseSpace), 0);
    [_bgView addSubview:_collectionView];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.frame = CGRectMake(0, _screenHeight - 50, _screenWidth, 50);
    _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)_currentIndex + 1,(long)_browseItemArray.count];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_countLabel];
}


#pragma mark UIColectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JDYBrowseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDYBrowserCell" forIndexPath:indexPath];
    if(cell)
    {
        // 停止加载
        [cell.loadingView stopAnimation];
        
        JDYBrowseModel *browseItem = [_browseItemArray objectAtIndex:indexPath.row];
        // 还原初始缩放比例
        cell.zoomScrollView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        cell.zoomScrollView.zoomScale = 1.0f;
        // 将scrollview的contentSize还原成缩放前
        cell.zoomScrollView.contentSize = CGSizeMake(_screenWidth, _screenHeight);
        cell.zoomScrollView.zoomImageView.contentMode = browseItem.smallImageView.contentMode;
        cell.zoomScrollView.zoomImageView.clipsToBounds = browseItem.smallImageView.clipsToBounds;
        [cell.loadingView jdy_centerToSuperViewWithSize:CGSizeMake(30, 30)];
        CGRect bigImageRect = [_verticalBigRectArray[indexPath.row] CGRectValue];
        if(_currentOrientation != UIDeviceOrientationPortrait)
        {
            bigImageRect = [_horizontalBigRectArray[indexPath.row] CGRectValue];
        }
        // 判断大图是否存在
        if([[SDImageCache sharedImageCache]diskImageExistsWithKey:browseItem.bigImageUrl])
        {
            // 显示大图
            [self showBigImage:cell.zoomScrollView.zoomImageView browseItem:browseItem rect:bigImageRect];
        }
        // 如果大图不存在
        else
        {
            _isFirstOpen = NO;
            // 加载大图
            [self loadBigImageWithBrowseItem:browseItem cell:cell rect:bigImageRect];
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
    return CGSizeMake(_screenWidth + kBrowseSpace, _screenHeight);
}

- (void)showBigImage:(UIImageView *)imageView browseItem:(JDYBrowseModel *)browseItem rect:(CGRect)rect
{
    // 取消当前请求防止复用问题
    [imageView sd_cancelCurrentImageLoad];
    // 如果存在直接显示图片
    imageView.image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:browseItem.bigImageUrl];
    // 第一次打开浏览页需要加载动画
    if(_isFirstOpen)
    {
        _isFirstOpen = NO;
        imageView.frame = [self getFrameInWindow:browseItem.smallImageView];
        [UIView animateWithDuration:0.5 animations:^{
            imageView.frame = rect;
        }];
    }
    else
    {
        imageView.frame = rect;
    }
}

// 加载大图
- (void)loadBigImageWithBrowseItem:(JDYBrowseModel *)browseItem cell:(JDYBrowseCollectionViewCell *)cell rect:(CGRect)rect
{
    UIImageView *imageView = cell.zoomScrollView.zoomImageView;
    // 加载圆圈显示
    [cell.loadingView startAnimation];
    // 默认为屏幕中间
    [imageView jdy_setFrameInSuperViewCenterWithSize:CGSizeMake(browseItem.smallImageView.jdyWidth, browseItem.smallImageView.jdyHeight)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:browseItem.bigImageUrl] placeholderImage:browseItem.smallImageView.image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 关闭图片浏览view的时候，不需要继续执行小图加载大图动画
        if(_collectionView.userInteractionEnabled)
        {
            // 停止加载
            [cell.loadingView stopAnimation];
            if(error)
            {
//                NSLog(@"图片加载失败");
            }
            else
            {
                // 图片加载成功
                [UIView animateWithDuration:0.5 animations:^{
                    imageView.frame = rect;
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
        _currentIndex = scrollView.contentOffset.x / (_screenWidth + kBrowseSpace);
        _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)_currentIndex + 1,(long)_browseItemArray.count];
    }
    _isRotate = NO;
}

#pragma mark Tap Method
- (void)tap:(JDYBrowseCollectionViewCell *)browseCell
{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    _snapshotView.hidden = NO;
    // 集合视图背景色设置为透明
    _collectionView.backgroundColor = [UIColor clearColor];
    // 动画结束前不可点击透明背景后的内容
    _collectionView.userInteractionEnabled = NO;
    // 显示状态栏
    [self setNeedsStatusBarAppearanceUpdate];
    // 停止加载
    NSArray *cellArray = _collectionView.visibleCells;
    for (JDYBrowseCollectionViewCell *cell in cellArray)
    {
        [cell.loadingView stopAnimation];
    }
    [_countLabel removeFromSuperview];
    _countLabel = nil;
    
    NSIndexPath *indexPath = [_collectionView indexPathForCell:browseCell];
    browseCell.zoomScrollView.zoomScale = 1.0f;
    JDYBrowseModel *browseItem = _browseItemArray[indexPath.row];
    CGRect rect = [self getFrameInWindow:browseItem.smallImageView];
    CGAffineTransform transform = CGAffineTransformMakeRotation(0);
    if(_currentOrientation == UIDeviceOrientationLandscapeLeft)
    {
        transform = CGAffineTransformMakeRotation(- M_PI / 2);
        rect = CGRectMake(rect.origin.y, JDY_SCREEN_WIDTH - rect.size.width - rect.origin.x, rect.size.height, rect.size.width);
    }
    else if(_currentOrientation == UIDeviceOrientationLandscapeRight)
    {
        transform = CGAffineTransformMakeRotation(M_PI / 2);
        rect = CGRectMake(JDY_SCREEN_HEIGHT - rect.size.height - rect.origin.y, rect.origin.x, rect.size.height, rect.size.width);
    }
    [UIView animateWithDuration:0.5 animations:^{
        browseCell.zoomScrollView.zoomImageView.transform = transform;
        browseCell.zoomScrollView.zoomImageView.frame = rect;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
}

- (BOOL)prefersStatusBarHidden
{
    if(!_collectionView.userInteractionEnabled)
    {
        return NO;
    }
    return YES;
}

#pragma mark Orientation Method
- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
    {
        _isRotate = YES;
        _currentOrientation = orientation;
        if(_currentOrientation == UIDeviceOrientationPortrait)
        {
            _screenWidth = JDY_SCREEN_WIDTH;
            _screenHeight = JDY_SCREEN_HEIGHT;
            [UIView animateWithDuration:0.5 animations:^{
                _bgView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
        else
        {
            _screenWidth = JDY_SCREEN_HEIGHT;
            _screenHeight = JDY_SCREEN_WIDTH;
            if(_currentOrientation == UIDeviceOrientationLandscapeLeft)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _bgView.transform = CGAffineTransformMakeRotation(M_PI / 2);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _bgView.transform = CGAffineTransformMakeRotation(- M_PI / 2);
                }];
            }
        }
        _bgView.frame = CGRectMake(0, 0, JDY_SCREEN_WIDTH, JDY_SCREEN_HEIGHT);
        _countLabel.frame = CGRectMake(0, _screenHeight - 50, _screenWidth, 50);
        [_collectionView.collectionViewLayout invalidateLayout];
        _collectionView.frame = CGRectMake(0, 0, _screenWidth + kBrowseSpace, _screenHeight);
        _collectionView.contentOffset = CGPointMake((_screenWidth + kBrowseSpace) * _currentIndex, 0);
        [_collectionView reloadData];
    }
}


@end
