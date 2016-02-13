//
//  UIView+JDYAutolayout.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/20.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "UIView+JDYAutolayout.h"
#import "Masonry.h"

@implementation UIView (JDYAutolayout)

- (void)jdy_euqalToSuperView
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)jdy_centerToSuperViewWithSize:(CGSize)size
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.superview);
        make.size.mas_equalTo(CGSizeMake(size.width, size.height));
    }];
}

@end
