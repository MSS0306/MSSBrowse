//
//  JDYBrowseView.h
//  JDYBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDYBrowseView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

- (id)initWithBrowseItemArray:(NSArray *)browseItemArray currentIndex:(NSInteger)currentIndex;

@end
