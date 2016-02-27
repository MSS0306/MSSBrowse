//
//  MSSBrowseModel.h
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MSSBrowseModel : NSObject

@property (nonatomic,copy)NSString *bigImageUrl;// 大图
@property (nonatomic,strong)UIImageView *smallImageView;// 小图

@end
