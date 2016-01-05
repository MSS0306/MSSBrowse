# JDYBrowse
iOS微信图片浏览模仿

![效果图竖屏](https://raw.githubusercontent.com/JDY0306/JDYBrowse/master/browse1.gif)
![效果图横屏](https://raw.githubusercontent.com/JDY0306/JDYBrowse/master/browse2.gif)

# 版本1.1
1.添加横竖屏(Masonry布局)
2.修改了图片加载错乱的bug
3.View改为ViewController控制
4.关闭图片浏览view的时候，不需要继续执行小图加载大图动画
5.修复转换坐标不准确问题

#Example
```Objective-c
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
NSArray *bigUrlArray = @[@"http://7xjtvh.com1.z0.glb.clouddn.com/browse01.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse02.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse03.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse04.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse05.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse06.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse07.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse08.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse09.jpg",@"http://7xjtvh.com1.z0.glb.clouddn.com/browse03.jpg"];
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
#联系
248394787@qq.com
