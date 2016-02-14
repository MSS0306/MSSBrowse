//
//  JDYBrowseViewController.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/23.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDYBrowseViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate>

- (instancetype)initWithBrowseItemArray:(NSArray *)browseItemArray currentIndex:(NSInteger)currentIndex;
- (void)showBrowseViewController;

@end
