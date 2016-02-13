//
//  UINavigationController+JDYRotateControl.m
//  JDYBrowse
//
//  Created by 于威 on 16/1/18.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "UINavigationController+JDYRotateControl.h"
#import "JDYBrowseViewController.h"

@implementation UINavigationController (JDYRotateControl)

- (BOOL)shouldAutorotate
{
    if([self.presentedViewController isKindOfClass:[JDYBrowseViewController class]])
    {
        return YES;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if([self.presentedViewController isKindOfClass:[JDYBrowseViewController class]])
    {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
