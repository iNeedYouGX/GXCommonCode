//
//  GXCollectionAutoLayoutDemoController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/23.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXCollectionAutoLayoutDemoController.h"
#import "CollectionAutoLayoutCell.h"

@interface GXCollectionAutoLayoutDemoController () <UICollectionViewDataSource>
/** 表 */
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation GXCollectionAutoLayoutDemoController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[
        @"https://img.alicdn.com/bao/uploaded/i3/1645598135/O1CN01uhnNXW29xsZst2Ln3_!!0-item_pic.jpg",
        @"https://img.alicdn.com/bao/uploaded/i1/3002204399/O1CN015WKdBE1iMmsoilicw_!!3002204399-0-pixelsss.jpg",
        @"https://img.alicdn.com/bao/uploaded/i2/2823345492/O1CN011xpRzI1qRNmiFPahI_!!0-item_pic.jpg",
        @"https://img.alicdn.com/bao/uploaded/i2/711139120/O1CN01kSXM022HF0e7qLcHC_!!711139120.jpg",
        @"https://img.alicdn.com/bao/uploaded/i2/1069640918/O1CN01YVPPXP1IeUB4j8n6u_!!0-item_pic.jpg",
        @"https://img.alicdn.com/bao/uploaded/i3/740529586/O1CN01AbOy4z2KgRH4fvA7j_!!0-item_pic.jpg",
        @"https://img.alicdn.com/bao/uploaded/i1/3002204399/O1CN015WKdBE1iMmsoilicw_!!3002204399-0-pixelsss.jpg",
        @"https://img.alicdn.com/bao/uploaded/i3/740529586/O1CN01AbOy4z2KgRH4fvA7j_!!0-item_pic.jpg",
        @"https://img.alicdn.com/bao/uploaded/i2/1069640918/O1CN01YVPPXP1IeUB4j8n6u_!!0-item_pic.jpg",
        @"https://img.alicdn.com/bao/uploaded/i1/441622457/O1CN01QgIT9Z1U1Livt84tk_!!0-item_pic.jpg"
    ];

    [self.view addSubview:self.collectionView];
}

#pragma mark - 创建UI
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.estimatedItemSize = CGSizeMake(SCR_WIDTH, 10);
        CGRect frame = CGRectMake(0, 10, SCR_WIDTH, SCR_HEIGHT - (IsiPhoneX ? (44 + 44) : (44 + 20)) - 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;

        // 注册cell
        [_collectionView registerClass:[CollectionAutoLayoutCell class] forCellWithReuseIdentifier:@"CollectionAutoLayoutCell"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionAutoLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionAutoLayoutCell" forIndexPath:indexPath];
    cell.backgroundColor = RANDOMCOLOR;
    cell.text = self.dataArray[indexPath.row];
    cell.img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", indexPath.row]];
    return cell;
}

@end
