# MSSBrowse
A simple iOS photo browse like wechat 微信图片浏览

![效果图](https://raw.githubusercontent.com/MSS0306/MSSBrowse/master/browse.gif)

# 说明
1.支持图片横屏浏览（您不需要开启横屏，因为是利用view的旋转做的横屏浏览效果，完美解决主流应用不支持横屏的问题）<br/>
2.强烈建议小图和大图为等比缩放的图片<br/>
3.动画浏览图片，类似微信的效果<br/>
4.长按手势弹框可保存图片，复制图片地址<br/>
5.支持双击和捏合手势放大和缩小图片<br/>
6.支持最低版本iOS7.0

# 版本2.2
1.修复加载动画复用圆圈变形问题<br/>
2.修复小图不存在时，大图加载不出来问题

# 版本2.1
1.添加浏览本地图片

# 版本2.0
1.放弃Autolayout,利用view的transform支持单个浏览页的横屏<br/>
2.双击图片放大缩小添加<br/>
3.长按手势弹框保存图片<br/>
4.部分代码优化

# 版本1.2
1.适配iOS7横屏显示错乱的问题<br/>
2.随主流应用，只有浏览图片页才可以横屏<br/>
3.解决加载本地图片第一次会闪一下的bug

# 版本1.1
1.添加横竖屏(Masonry布局)<br/>
2.修改了图片加载错乱的bug<br/>
3.View改为ViewController控制<br/>
4.关闭图片浏览view的时候，不需要继续执行小图加载大图动画<br/>
5.修复转换坐标不准确问题

#Example
1.加载网络图片<br/>
```Objective-c
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
// bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
[bvc showBrowseViewController];
}
```
<br/>
2.加载本地图片<br/>
```Objective-c
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
// 加载本地图片
NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
int i = 0;
for(i = 0;i < [_smallUrlArray count];i++)
{
UIImageView *imageView = [self.view viewWithTag:i + 100];
MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
// browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
browseItem.bigImage = imageView.image;// 大图赋值
browseItem.smallImageView = imageView;// 小图
[browseItemArray addObject:browseItem];
}
MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
[bvc showBrowseViewController];
}
```

