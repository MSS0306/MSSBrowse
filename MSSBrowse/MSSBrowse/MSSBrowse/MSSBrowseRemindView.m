//
//  MSSBrowseRemindView.m
//  MSSBrowse
//
//  Created by 于威 on 16/2/14.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSBrowseRemindView.h"
#import "UIView+MSSLayout.h"

@interface MSSBrowseRemindView ()

@property (nonatomic,strong)UILabel *remindLabel;
@property (nonatomic,strong)UIView *maskView;

@end

@implementation MSSBrowseRemindView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createRemindView];
    }
    return self;
}

- (void)createRemindView
{
    self.alpha = 0;
    
    _maskView = [[UIView alloc]init];
    _maskView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.5f;
    _maskView.layer.cornerRadius = 5.0f;
    _maskView.layer.masksToBounds = YES;
    [self addSubview:_maskView];
    
    _remindLabel = [[UILabel alloc]init];
    _remindLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _remindLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _remindLabel.textColor = [UIColor whiteColor];
    [self addSubview:_remindLabel];
}

- (void)showRemindViewWithText:(NSString *)text
{
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_remindLabel.font} context:nil];
    CGSize size = textRect.size;
    [_maskView mss_setFrameInSuperViewCenterWithSize:CGSizeMake(size.width + 20, size.height + 40)];
    [_remindLabel mss_setFrameInSuperViewCenterWithSize:CGSizeMake(size.width, size.height)];
    _remindLabel.text = text;
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)hideRemindView
{
    self.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        
    }];
}

@end
