//
//  GXCollectionViewDemoController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/1/10.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXCollectionViewDemoController.h"

@interface GXCollectionViewDemoController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 表 */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation GXCollectionViewDemoController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.collectionView];
}


#pragma mark - 创建UI
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGRect frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT - (IsiPhoneX ? (44 + 44) : (44 + 20)));
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;

        // 注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        // 注册sectionHeader
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        // 注册sectionFooter
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

// cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = RANDOMCOLOR;
    return cell;
}

// 头视图样式
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) { // 头
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];
        header.backgroundColor = UIColorFromRGB(0xF5F5F5);

        UIImageView *imageView = [header viewWithTag:101];
        if (imageView == nil) {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_no_data"]];
            imageView.tag = 101;
            [header addSubview:imageView];
            imageView.centerX = SCR_WIDTH / 2.0;
            imageView.centerY = 90;
        }
        return header;
    } else if (kind == UICollectionElementKindSectionFooter) { // 尾
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"forIndexPath:indexPath];
        header.backgroundColor = UIColorFromRGB(0xF5F5F5);

        UIImageView *imageView = [header viewWithTag:101];
        if (imageView == nil) {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qs-404"]];
            imageView.tag = 101;
            [header addSubview:imageView];
            imageView.centerX = SCR_WIDTH / 2.0;
            imageView.centerY = 90;
        }
        return header;
    } else {
        return nil;
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50); // 每个块尺寸
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 15); // 上下左右的间距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10; // 最小"行"间距
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 100; // 最小"间"距
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 180); // 头视图高度
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 200); // 尾视图高度
}


@end
