//
//  GXFlowLayoutController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/12/20.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXFlowLayoutController.h"
#import "GXLineLayout.h"
#import "GXGridLayout.h"
#import "GXPhotoCell.h"

@interface GXFlowLayoutController () <UICollectionViewDataSource>

@end

@implementation GXFlowLayoutController
static NSString *ID = @"PhotoCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /**
     1.  创建布局, 默认排布像流水一样的布局
     */
    GXLineLayout *flowLayout = [[GXLineLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(200, 300); // 小格子的大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 滚动的方向
    
    /**
     1. 自己算的格子布局, 继承于抽象类
     */
    GXGridLayout *gridLayout = [[GXGridLayout alloc] init];
    
    
    // 创建collectView
    /**
     1. 创建时必须设置布局, 视图根据传进来的布局参数来创建
     2. 如果你想改变样式, 就改变flowLayout就好了
     */
    CGFloat collectWH = self.view.frame.size.width;
    CGRect frame = CGRectMake(0, 150, collectWH, collectWH);
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectView.dataSource = self;
    [self.view addSubview:collectView];
    
    // 必须注册
    [collectView registerNib:[UINib nibWithNibName:NSStringFromClass([GXPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", indexPath.row + 1]];
    
    
//    cell.backgroundColor = [UIColor orangeColor];
//    这个是重用的简单写法
//    UILabel *label;
//    label = [cell.contentView viewWithTag:10];
//    if (label == nil) {
//        label = [[UILabel alloc] init];
//        label.tag = 10;
//        [cell.contentView addSubview:label];
//    }
//    label.text = [NSString stringWithFormat:@"%zd", indexPath.row];
//    [label sizeToFit];
    
    return cell;
}



@end
