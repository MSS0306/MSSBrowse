# JDYBrowse
A simple iOS photo browse like wechat 微信图片浏览

![效果图竖屏](https://raw.githubusercontent.com/JDY0306/JDYBrowse/master/browse1.gif)

#联系
iOS开发技术交流群:529043462

# 说明
原来1.2版本用Autolayout实现横竖屏遇上了种种问题（其中调用旋转屏幕的私有API存在风险）<br/>
为了更好的支持主流应用的需求,改成了用view的transform实现浏览页面的横屏,并对部分代码进行了优化<br/>
原来1.2版本旧代码单独存放了一个文件夹,其实已经没有用了

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
NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
int i = 0;
for(i = 0;i < [_smallUrlArray count];i++)
{
UIImageView *imageView = [self.view viewWithTag:i + 100];
JDYBrowseModel *browseItem = [[JDYBrowseModel alloc]init];
browseItem.bigImageUrl = bigUrlArray[i];// 大图url地址
browseItem.smallImageView = imageView;// 小图
[browseItemArray addObject:browseItem];
}
JDYCollectionViewCell *cell = (JDYCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
JDYBrowseViewController *bvc = [[JDYBrowseViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
[bvc showBrowseViewController];
}
```
