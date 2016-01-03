//
//  UINavigationController+JDYShouldAutorotate.m
//  JDYBrowse
//
//  Created by 于威 on 16/1/2.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "UINavigationController+JDYShouldAutorotate.h"

@implementation UINavigationController (JDYShouldAutorotate)

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
