//
//  MSSBrowseLocalViewController.m
//  MSSBrowse
//
//  Created by 于威 on 16/4/26.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSBrowseLocalViewController.h"

@implementation MSSBrowseLocalViewController

- (void)loadBrowseImageWithBrowseItem:(MSSBrowseModel *)browseItem Cell:(MSSBrowseCollectionViewCell *)cell bigImageRect:(CGRect)bigImageRect
{
    cell.loadingView.hidden = YES;
    UIImageView *imageView = cell.zoomScrollView.zoomImageView;
    if(browseItem.bigImage)
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
    
    // 第一次打开浏览页需要加载动画
    if(self.isFirstOpen)
    {
        self.isFirstOpen = NO;
        imageView.frame = [self getFrameInWindow:browseItem.smallImageView];
        [UIView animateWithDuration:0.5 animations:^{
            imageView.frame = bigImageRect;
        }];
    }
    else
    {
        imageView.frame = bigImageRect;
    }
}

@end
