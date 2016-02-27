//
//  MSSBrowseActionSheetCell.m
//  MSSBrowse
//
//  Created by 于威 on 16/2/14.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSBrowseActionSheetCell.h"
#import "MSSBrowseDefine.h"

@implementation MSSBrowseActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = [UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:1.0f];
    [self.contentView addSubview:_bottomLineView];
}

@end
