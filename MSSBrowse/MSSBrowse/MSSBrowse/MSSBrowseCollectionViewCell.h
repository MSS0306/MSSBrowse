//
//  MSSBrowseCollectionViewCell.h
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSBrowseLoadingImageView.h"
#import "MSSBrowseZoomScrollView.h"

@class MSSBrowseCollectionViewCell;

typedef void(^MSSBrowseCollectionViewCellTapBlock)(MSSBrowseCollectionViewCell *browseCell);
typedef void(^MSSBrowseCollectionViewCellLongPressBlock)(MSSBrowseCollectionViewCell *browseCell);

@interface MSSBrowseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)MSSBrowseZoomScrollView *zoomScrollView; // 滚动视图
@property (nonatomic,strong)MSSBrowseLoadingImageView *loadingView; // 加载视图

- (void)tapClick:(MSSBrowseCollectionViewCellTapBlock)tapBlock;
- (void)longPress:(MSSBrowseCollectionViewCellLongPressBlock)longPressBlock;

@end
