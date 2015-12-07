//
//  JDYBrowseCollectionViewCell.m
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "JDYBrowseCollectionViewCell.h"
#import "JDYBrowseDefine.h"

@interface JDYBrowseCollectionViewCell ()

@property (nonatomic,copy)UITapGestureRecognizer *tap;
@property (nonatomic,copy)JDYBrowseCollectionViewCellTapBlock tapBlock;

@end

@implementation JDYBrowseCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _zoomScrollView = [[JDYBrowseZoomScrollView alloc]initWithFrame:CGRectMake(0, 0, JDY_SCREEN_WIDTH, JDY_SCREEN_HEIGHT)];
    [self.contentView addSubview:_zoomScrollView];
    
    _loadingView = [[JDYBrowseLoadingView alloc]initWithFrame:CGRectMake((JDY_SCREEN_WIDTH - 30) / 2, (JDY_SCREEN_HEIGHT - 30) / 2, 30, 30)];
    [self.contentView addSubview:_loadingView];
    
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.contentView addGestureRecognizer:_tap];
}

- (void)tapClick:(JDYBrowseCollectionViewCellTapBlock)tapBlock
{
    _tapBlock = tapBlock;
}

- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    if(_tapBlock)
    {
        _tapBlock(self);
    }
}


@end
