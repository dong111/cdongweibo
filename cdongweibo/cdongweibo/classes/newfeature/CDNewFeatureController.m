//
//  CDNewFeatureController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDNewFeatureController.h"

@interface CDNewFeatureController ()

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
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //cell大小由layout决定
//    cell.frame = [UIScreen mainScreen].bounds;
    cell.backgroundColor = [UIColor grayColor];
    
    // Configure the cell
    
    return cell;
}

@end
