//
//  UIImage+JDYScale.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/6.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JDYScale)

// 得到图像显示完整后的宽度和高度
- (CGSize)jdy_getSizeAfterFitWithWidth:(CGFloat)width height:(CGFloat)height;

@end
