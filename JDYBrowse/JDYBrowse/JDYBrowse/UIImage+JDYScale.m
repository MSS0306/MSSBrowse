//
//  UIImage+JDYScale.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/6.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "UIImage+JDYScale.h"

@implementation UIImage (JDYScale)

// 得到图像显示完整后的宽度和高度
- (CGSize)jdy_getSizeAfterFit
{
    CGSize size;
    CGFloat widthRatio = [UIScreen mainScreen].bounds.size.width / self.size.width;
    CGFloat heightRatio = [UIScreen mainScreen].bounds.size.height / self.size.height;
    CGFloat scale = MIN(widthRatio, heightRatio);
    size.width = scale * self.size.width;
    size.height = scale * self.size.height;
    return size;
}

@end
