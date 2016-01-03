//
//  UIView+JDYAutolayout.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/20.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JDYAutolayout)

- (void)jdy_euqalToSuperView;
- (void)jdy_centerToSuperViewWithSize:(CGSize)size;

@end
