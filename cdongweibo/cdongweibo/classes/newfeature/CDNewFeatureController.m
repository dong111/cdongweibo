//
//  CDNewFeatureController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDNewFeatureController.h"
#import "CDNewFeatureCell.h"
#import "CDUitiity.h"

@interface CDNewFeatureController ()

@property (nonatomic,strong) UIPageControl *pageController;

@end

@implementation CDNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

//重写init方法
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //layout设置cell 大小,行距离 布局方向
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}

//使用UICollectionView步骤
//1.初始化时候设置布局参数
//2.在view加载时候给CollectionView注册cell
//3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[CDNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;//取消弹簧效果
    self.collectionView.showsHorizontalScrollIndicator = NO;//滚动条indicator
    
    //添加PageController
    [self setUPPageController];
}
//添加PageController
- (void) setUPPageController
{
    //添加pageController 只需要添加位置 不需要设置代销
    UIPageControl *pageController = [[UIPageControl alloc]init];
    //参数设置
    pageController.numberOfPages = 4;//多少页
    //设置indicator（指示器的颜色-->滚动的点）
    pageController.pageIndicatorTintColor = [UIColor blackColor];
    pageController.currentPageIndicatorTintColor  = [UIColor redColor];
    
    //通过center设置位置
    pageController.center = CGPointMake(self.view.width*0.5, self.view.height-20);
    self.pageController = pageController;
    [self.view addSubview:pageController];
}

#pragma mark UIScrollViewDelegate 方法实现
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取当前的偏移量，计算单前第几页
   int page =  scrollView.contentOffset.x / scrollView.bounds.size.width +0.5;
    self.pageController.currentPage = page;
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //cell大小由layout决定
//    cell.frame = [UIScreen mainScreen].bounds;
//    cell.backgroundColor = [UIColor grayColor];
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",(indexPath.row+1)];
    if (SCREEN_WIDTH>400) {// 5 , 6 , 6 plus
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",(indexPath.row+1)];
    }
    [cell setImage:[UIImage imageNamed:imageName]];
    [cell setIndexPath:indexPath count:4];
//    NSLog(@"%@",cell);
    
    return cell;
}

@end
