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
// 加载网络图片大图url地址
@property (nonatomic,copy)NSString *bigImageUrl;
// 加载本地图片（下面三个属性传一个即可）
@property (nonatomic,copy)NSString *bigImageLocalPath;// 建议使用本地图片路径（减少内存使用）
@property (nonatomic,strong)NSData *bigImageData;
@property (nonatomic,strong)UIImage *bigImage;
// 小图（用来转换坐标用）
@property (nonatomic,strong)UIImageView *smallImageView;

@end
