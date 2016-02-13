//
//  UIView+JDYLayout.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JDYLayout)

- (CGFloat)jdyLeft;
- (CGFloat)jdyRight;
- (CGFloat)jdyBottom;
- (CGFloat)jdyTop;
- (CGFloat)jdyHeight;
- (CGFloat)jdyWidth;

- (void)setJdyX:(CGFloat)jdyX;
- (void)setJdyY:(CGFloat)jdyY;
- (void)setJdyWidth:(CGFloat)jdyWidth;
- (void)setJdyHeight:(CGFloat)jdyHeight;

- (void)jdy_setFrameInSuperViewCenterWithSize:(CGSize)size;

@end
