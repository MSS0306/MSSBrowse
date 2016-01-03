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
    _zoomScrollView = [[JDYBrowseZoomScrollView alloc]init];
    [self.contentView addSubview:_zoomScrollView];
    [_zoomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-kBrowseSpace);
    }];
    
    _loadingView = [[JDYBrowseLoadingView alloc]init];
    [_zoomScrollView addSubview:_loadingView];
    [_loadingView jdy_centerToSuperViewWithSize:CGSizeMake(30, 30)];
    
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
