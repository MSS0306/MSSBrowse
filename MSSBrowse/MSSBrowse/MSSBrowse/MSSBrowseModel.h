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

@property (nonatomic,copy)NSString *bigImageUrl;// 加载网络图片大图url地址
// 加载本地图片（下面两个属性传一个即可）
@property (nonatomic,strong)NSData *bigImageData;
@property (nonatomic,strong)UIImage *bigImage;

@property (nonatomic,strong)UIImageView *smallImageView;// 小图（用来转换坐标用）

@end
