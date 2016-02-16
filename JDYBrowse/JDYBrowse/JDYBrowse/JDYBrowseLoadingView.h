//
//  JDYBrowseLoadingView.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDYBrowseLoadingView : UIView

- (void)startAnimation;
- (void)stopAnimation;
@property (nonatomic,assign)CGFloat angle;

@end
