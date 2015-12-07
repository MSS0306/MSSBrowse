//
//  JDYCollectionViewCell.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/6.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "JDYCollectionViewCell.h"

@implementation JDYCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_imageView];
}

@end
