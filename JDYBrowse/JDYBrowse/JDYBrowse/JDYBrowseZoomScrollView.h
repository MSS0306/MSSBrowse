//
//  JDYBrowseZoomScrollView.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JDYBrowseZoomScrollViewTapBlock)(void);

@interface JDYBrowseZoomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *zoomImageView;

- (void)tapClick:(JDYBrowseZoomScrollViewTapBlock)tapBlock;

@end
