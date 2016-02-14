//
//  JDYBrowseActionSheet.h
//  JDYBrowse
//
//  Created by 于威 on 16/2/14.
//  Copyright © 2016年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JDYBrowseActionSheetDidSelectedAtIndexBlock)(NSInteger index);

@interface JDYBrowseActionSheet : UIView

- (instancetype)initWithTitleArray:(NSArray *)titleArray cancelButtonTitle:(NSString *)cancelTitle didSelectedBlock:(JDYBrowseActionSheetDidSelectedAtIndexBlock)selectedBlock;
- (void)showInView:(UIView *)view;
// transform时更新frame
- (void)updateFrame;

@end
