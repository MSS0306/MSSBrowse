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

@class JDYBrowseCollectionViewCell;

typedef void(^JDYBrowseCollectionViewCellTapBlock)(JDYBrowseCollectionViewCell *browseCell);
typedef void(^JDYBrowseCollectionViewCellLongPressBlock)(JDYBrowseCollectionViewCell *browseCell);

@interface JDYBrowseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)JDYBrowseZoomScrollView *zoomScrollView; // 滚动视图
@property (nonatomic,strong)JDYBrowseLoadingView *loadingView; // 加载视图

- (void)tapClick:(JDYBrowseCollectionViewCellTapBlock)tapBlock;
- (void)longPress:(JDYBrowseCollectionViewCellLongPressBlock)longPressBlock;

@end
