//
//  JDYBrowseLoadingView.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "JDYBrowseLoadingView.h"

@interface JDYBrowseLoadingView ()

@property (nonatomic,strong)NSTimer *timer;

@end

@implementation JDYBrowseLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.backgroundColor = [UIColor clearColor];
    self.hidden = NO;
}

- (void)transAnimation
{
    _angle += 6.0f;
    self.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    if (_angle > 360.f) {
        _angle = 0;
    }
}

- (void)startAnimation
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(transAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    self.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    self.hidden = NO;
}

- (void)stopAnimation
{
    [_timer invalidate];
    self.hidden = YES;
    self.transform = CGAffineTransformMakeRotation(0);
}

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"jdy_browseLoading"];
    [image drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
}


@end
