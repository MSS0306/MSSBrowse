# JDYBrowse
iOS微信图片浏览模仿

![(效果图)](http://img.blog.csdn.net/20151208214457636?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

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
JDYBrowseView *browseView = [[JDYBrowseView alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
[self.view addSubview:browseView];
}

```
