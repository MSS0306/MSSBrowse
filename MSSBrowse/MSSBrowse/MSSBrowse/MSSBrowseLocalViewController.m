//
//  MSSBrowseLocalViewController.m
//  MSSBrowse
//
//  Created by 于威 on 16/4/26.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSBrowseLocalViewController.h"
#import "UIImage+MSSScale.h"

@implementation MSSBrowseLocalViewController

- (void)loadBrowseImageWithBrowseItem:(MSSBrowseModel *)browseItem Cell:(MSSBrowseCollectionViewCell *)cell bigImageRect:(CGRect)bigImageRect
{
    cell.loadingView.hidden = YES;
    UIImageView *imageView = cell.zoomScrollView.zoomImageView;
    if(browseItem.bigImageLocalPath)
    {
        NSData *imageData = [[NSData alloc]initWithContentsOfFile:browseItem.bigImageLocalPath];
        imageView.image = [[UIImage alloc]initWithData:imageData];
    }
    else if(browseItem.bigImage)
    {
        imageView.image = browseItem.bigImage;
    }
    else if(browseItem.bigImageData)
    {
        imageView.image = [[UIImage alloc]initWithData:browseItem.bigImageData];
    }
    else
    {
        imageView.image = nil;
    }
    // 当大图frame为空时，需要大图加载完成后重新计算坐标
    CGRect bigRect = [self getBigImageRectIfIsEmptyRect:bigImageRect bigImage:imageView.image];
    // 第一次打开浏览页需要加载动画
    if(self.isFirstOpen)
    {
        self.isFirstOpen = NO;
        imageView.frame = [self getFrameInWindow:browseItem.smallImageView];
        [UIView animateWithDuration:0.5 animations:^{
            imageView.frame = bigRect;
        }];
    }
    else
    {
        imageView.frame = bigRect;
    }
}

// 当大图frame为空时，需要大图加载完成后重新计算坐标
- (CGRect)getBigImageRectIfIsEmptyRect:(CGRect)rect bigImage:(UIImage *)bigImage
{
    if(CGRectIsEmpty(rect))
    {
        return [bigImage mss_getBigImageRectSizeWithScreenWidth:self.screenWidth screenHeight:self.screenHeight];
    }
    return rect;
}

@end
