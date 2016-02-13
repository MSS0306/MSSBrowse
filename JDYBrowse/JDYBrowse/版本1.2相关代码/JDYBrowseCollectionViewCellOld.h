//
//  JDYBrowseCollectionViewCell.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDYBrowseLoadingView.h"
#import "JDYBrowseZoomScrollView.h"

@class JDYBrowseCollectionViewCellOld;

typedef void(^JDYBrowseCollectionViewCellTapBlock)(JDYBrowseCollectionViewCellOld *browseCell);

@interface JDYBrowseCollectionViewCellOld : UICollectionViewCell

@property (nonatomic,strong)JDYBrowseZoomScrollView *zoomScrollView; // 滚动视图
@property (nonatomic,strong)JDYBrowseLoadingView *loadingView; // 加载视图

- (void)tapClick:(JDYBrowseCollectionViewCellTapBlock)tapBlock;

@end
