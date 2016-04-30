//
//  MSSBrowseLoadingImageView.m
//  MSSBrowse
//
//  Created by 于威 on 16/4/29.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSBrowseLoadingImageView.h"

@interface MSSBrowseLoadingImageView ()

@property (nonatomic,strong)CABasicAnimation *rotationAnimation;

@end

@implementation MSSBrowseLoadingImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createImageView];
    }
    return self;
}

- (void)createImageView
{
    self.image = [UIImage imageNamed:@"mss_browseLoading"];
    _rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    _rotationAnimation.duration = 0.6f;
    _rotationAnimation.repeatCount = FLT_MAX;
}

- (void)startAnimation
{
    self.hidden = NO;
    [self.layer addAnimation:_rotationAnimation
                      forKey:@"rotateAnimation"];
}

- (void)stopAnimation
{
    self.hidden = YES;
    [self.layer removeAnimationForKey:@"rotateAnimation"];
}


@end
