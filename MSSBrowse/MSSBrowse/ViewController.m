//
//  ViewController.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "ViewController.h"
#import "MSSBrowseDefine.h"
#import "UIImageView+WebCache.h"
#import "MSSCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *smallUrlArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 70, 100, 50);
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"清空缓存" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    _smallUrlArray = @[@"http://7xjtvh.com1.z0.glb.clouddn.com/browse01_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse02_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse03_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse04_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse05_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse06_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse07_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse08_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse09_s.jpg"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, btn.mssBottom, MSS_SCREEN_WIDTH, MSS_SCREEN_HEIGHT - btn.mssBottom) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    //cell注册
    [_collectionView registerClass:[MSSCollectionViewCell class] forCellWithReuseIdentifier:@"MSSCollectionViewCell"];
    [self.view addSubview:_collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_smallUrlArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCollectionViewCell" forIndexPath:indexPath];
    if (cell)
    {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_smallUrlArray[indexPath.row]]];
        cell.imageView.tag = indexPath.row + 100;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *bigUrlArray = @[@"http://7xjtvh.com1.z0.glb.clouddn.com/browse01.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse02.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse03.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse04.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse05.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse06.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse07.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse08.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse09.jpg"];
    // 加载网络图片
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < [_smallUrlArray count];i++)
    {
        UIImageView *imageView = [self.view viewWithTag:i + 100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = bigUrlArray[i];// 加载网络图片大图地址
        browseItem.smallImageView = imageView;// 小图
        [browseItemArray addObject:browseItem];
    }
    MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
//    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController];
    
//    // 加载本地图片
//    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
//    int i = 0;
//    for(i = 0;i < [_smallUrlArray count];i++)
//    {
//        UIImageView *imageView = [self.view viewWithTag:i + 100];
//        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
////        browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
//        browseItem.bigImage = imageView.image;// 大图赋值
//        browseItem.smallImageView = imageView;// 小图
//        [browseItemArray addObject:browseItem];
//    }
//    MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//    MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
//    [bvc showBrowseViewController];
}


- (void)btnClick
{
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        [_collectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
