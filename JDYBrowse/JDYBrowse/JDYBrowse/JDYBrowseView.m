//
//  JDYBrowseView.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//


#define kSpace 50.0f

#import "JDYBrowseView.h"
#import "JDYBrowseCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIImage+JDYScale.h"
#import "JDYBrowseDefine.h"

@interface JDYBrowseView ()

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *browseItemArray;
@property (nonatomic,assign)BOOL isFirstOpen;
@property (nonatomic,assign)NSInteger currentIndex;

@end

@implementation JDYBrowseView

- (id)initWithBrowseItemArray:(NSArray *)browseItemArray currentIndex:(NSInteger)currentIndex
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        _browseItemArray = browseItemArray;
        _currentIndex = currentIndex;
        [self createBrowseView];
    }
    return self;
}

- (void)createBrowseView
{
    self.frame = CGRectMake(0, 0, JDY_SCREEN_WIDTH, JDY_SCREEN_HEIGHT);
    self.backgroundColor = [UIColor clearColor];
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
    flowLayout.itemSize = CGSizeMake(JDY_SCREEN_WIDTH + kSpace, JDY_SCREEN_HEIGHT);
    // 每行内部cell item的间距
    flowLayout.minimumInteritemSpacing = 0;
    // 每行的间距
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, JDY_SCREEN_WIDTH + kSpace, JDY_SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    //cell注册
    [_collectionView registerClass:[JDYBrowseCollectionViewCell class] forCellWithReuseIdentifier:@"Browser_Cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.contentOffset = CGPointMake(_currentIndex * (JDY_SCREEN_WIDTH + kSpace), 0);
    _collectionView.backgroundColor = [UIColor blackColor];
    [self addSubview:_collectionView];
}

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
    return [_browseItemArray count];
}

- (void)showBigImage:(UIImageView *)imageView browseItem:(JDYBrowseModel *)browseItem
{
    // 如果存在直接显示
    UIImage *bigImage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:browseItem.bigImageUrl];
    imageView.image = bigImage;
    CGSize size = [bigImage jdy_getSizeAfterFit];
    // 第一次打开浏览页需要加载动画
    if(_isFirstOpen)
    {
        imageView.frame = [self getFrameInWindow:browseItem.smallImageView];
        [UIView animateWithDuration:0.5 animations:^{
            imageView.frame = CGRectMake((JDY_SCREEN_WIDTH - size.width) / 2, (JDY_SCREEN_HEIGHT - size.height) / 2, size.width, size.height);
        }];
        _isFirstOpen = NO;
    }
    else
    {
        imageView.frame = CGRectMake((JDY_SCREEN_WIDTH - size.width) / 2, (JDY_SCREEN_HEIGHT - size.height) / 2, size.width, size.height);
    }
}

// 加载大图
- (void)loadBigImage:(UIImageView *)imageView browseItem:(JDYBrowseModel *)browseItem cell:(JDYBrowseCollectionViewCell *)cell
{
    // 加载圆圈显示
    [cell.loadingView startAnimation];
    // 默认为屏幕中间
    imageView.frame = CGRectMake((self.jdyWidth - browseItem.smallImageView.jdyWidth) / 2, (self.jdyHeight - browseItem.smallImageView.jdyHeight) / 2, browseItem.smallImageView.jdyWidth, browseItem.smallImageView.jdyHeight);
    
    // 默认图片为小图
    [imageView sd_setImageWithURL:[NSURL URLWithString:browseItem.bigImageUrl] placeholderImage:browseItem.smallImageView.image options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 此处可做图片加载进度
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
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
    }];
}

- (void)tap:(JDYBrowseCollectionViewCell *)browseCell
{
    // 停止加载
    NSArray *cellArray = _collectionView.visibleCells;
    for (JDYBrowseCollectionViewCell *cell in cellArray)
    {
        [cell.loadingView stopAnimation];
    }
    NSIndexPath *indexPath = [_collectionView indexPathForCell:browseCell];
    browseCell.zoomScrollView.zoomScale = 1.0f;
    // 集合视图背景色设置为透明
    _collectionView.backgroundColor = [UIColor clearColor];
    // 动画结束前不可点击透明背景后的内容
    _collectionView.userInteractionEnabled = NO;
    JDYBrowseModel *browseItem = _browseItemArray[indexPath.row];
    CGRect rect = [self getFrameInWindow:browseItem.smallImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        browseCell.zoomScrollView.zoomImageView.frame = rect;
    } completion:^(BOOL finished) {
        // imageView设置为填满并切去多于的边
        [self removeFromSuperview];
    }];
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view
{
    return [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
}

@end
