//
//  UIView+JDYLayout.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "UIView+JDYLayout.h"

@implementation UIView (JDYLayout)

- (CGFloat)jdyLeft
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)jdyRight
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)jdyBottom
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)jdyTop
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)jdyHeight
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)jdyWidth
{
    return CGRectGetWidth(self.frame);
}

- (void)setJdyX:(CGFloat)jdyX
{
    CGRect rect = self.frame;
    rect.origin.x = jdyX;
    self.frame = rect;
}

- (void)setJdyY:(CGFloat)jdyY
{
    CGRect rect = self.frame;
    rect.origin.y = jdyY;
    self.frame = rect;
}

- (void)setJdyWidth:(CGFloat)jdyWidth
{
    CGRect rect = self.frame;
    rect.size.width = jdyWidth;
    self.frame = rect;
}

- (void)setJdyHeight:(CGFloat)jdyHeight
{
    CGRect rect = self.frame;
    rect.size.height = jdyHeight;
    self.frame = rect;
}

- (void)jdy_setFrameInSuperViewCenterWithSize:(CGSize)size
{
    self.frame = CGRectMake((self.superview.jdyWidth - size.width) / 2, (self.superview.jdyHeight - size.height) / 2, size.width, size.height);
}

@end
