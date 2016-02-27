//
//  UIView+MSSLayout.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "UIView+MSSLayout.h"

@implementation UIView (MSSLayout)

- (CGFloat)mssLeft
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)mssRight
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)mssBottom
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)mssTop
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)mssHeight
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)mssWidth
{
    return CGRectGetWidth(self.frame);
}

- (void)setMssX:(CGFloat)mssX
{
    CGRect rect = self.frame;
    rect.origin.x = mssX;
    self.frame = rect;
}

- (void)setMssY:(CGFloat)mssY
{
    CGRect rect = self.frame;
    rect.origin.y = mssY;
    self.frame = rect;
}

- (void)setMssWidth:(CGFloat)mssWidth
{
    CGRect rect = self.frame;
    rect.size.width = mssWidth;
    self.frame = rect;
}

- (void)setMssHeight:(CGFloat)mssHeight
{
    CGRect rect = self.frame;
    rect.size.height = mssHeight;
    self.frame = rect;
}

- (void)mss_setFrameInSuperViewCenterWithSize:(CGSize)size
{
    self.frame = CGRectMake((self.superview.mssWidth - size.width) / 2, (self.superview.mssHeight - size.height) / 2, size.width, size.height);
}

@end
