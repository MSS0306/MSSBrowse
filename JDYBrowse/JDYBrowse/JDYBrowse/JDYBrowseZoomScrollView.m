//
//  JDYBrowseZoomScrollView.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "JDYBrowseZoomScrollView.h"
#import "JDYBrowseDefine.h"

@implementation JDYBrowseZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createZoomScrollView];
    }
    return self;
}

- (void)createZoomScrollView
{
    self.delegate = self;
    self.minimumZoomScale = 1;
    self.maximumZoomScale = 3;
    
    _zoomImageView = [[UIImageView alloc]init];
    _zoomImageView.userInteractionEnabled = YES;
    [self addSubview:_zoomImageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // 延中心点缩放
    CGRect rect = _zoomImageView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    if (rect.size.width < self.jdyWidth) {
        rect.origin.x = floorf((self.jdyWidth - rect.size.width) / 2.0);
    }
    if (rect.size.height < self.jdyHeight) {
        rect.origin.y = floorf((self.jdyHeight - rect.size.height) / 2.0);
    }
    _zoomImageView.frame = rect;
}

@end
