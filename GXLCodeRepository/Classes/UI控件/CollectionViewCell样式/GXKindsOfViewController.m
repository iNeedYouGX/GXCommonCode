//
//  GXKindsOfViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/12/27.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXKindsOfViewController.h"
#import "CZFestivalGoodsColLayoutView.h"
#import "GXTestViewController1.h"
#import "CZCollectionTypeOneCell.h"
#import "CZguessWhatYouLikeCell.h"

@interface GXKindsOfViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/** 总数据 */
@property (nonatomic, strong) NSDictionary *dataSourceDic;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation GXKindsOfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    // 获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KindsOfViewData" ofType:@"json"];
    NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    self.dataSourceDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    [self createCollectionView];
}

- (UIView *)createUI
{
    CGRect frame = CGRectMake(0, 0, SCR_WIDTH, 167 + 20);
    NSArray *list = self.dataSourceDic[@"type1"];
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:frame];
    scrollerView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    for (int i = 0; i < list.count; i++) {
        CGFloat y = 10;
        CGFloat w = 100;
        CGFloat h = 167;
        CGFloat x = 15 + (w + 10) * i;
        CZFestivalGoodsColLayoutView *view = (CZFestivalGoodsColLayoutView *)[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CZFestivalGoodsColLayoutView class]) owner:nil options:nil] firstObject];
        view.frame = CGRectMake(x, y, w, h);
        view.index = i;
        view.dataDic = list[i];
        [scrollerView addSubview:view];
        scrollerView.contentSize = CGSizeMake(CZGetX(view) + 15, 0);
    }
    return scrollerView;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    CGRect frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT - (IsiPhoneX ? (44 + 44) : (44 + 20)));
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.view addSubview:_collectionView];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    // 注册
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CZCollectionTypeOneCell class]) bundle:nil] forCellWithReuseIdentifier:@"CZCollectionTypeOneCell"]; // 一行
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CZguessWhatYouLikeCell class]) bundle:nil] forCellWithReuseIdentifier:@"CZguessWhatYouLikeCell"]; // 两行

    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CZMVSDefaultVCDelegate"];
}

// 头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CZMVSDefaultVCDelegate" forIndexPath:indexPath];
        [headerView addSubview:[self createUI]];
        return headerView;
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        NSDictionary *dic = self.dataSourceDic[@"type2"][indexPath.row];
        CZCollectionTypeOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CZCollectionTypeOneCell" forIndexPath:indexPath];
        cell.dataDic = dic;
        return cell;
    } else {
        NSDictionary *dic = self.dataSourceDic[@"type3"][indexPath.row];
        CZguessWhatYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CZguessWhatYouLikeCell" forIndexPath:indexPath];
        cell.dataDic = dic;
        return cell;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.dataSourceDic[@"type2"] count];
    } else {
        return [self.dataSourceDic[@"type3"] count];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCR_WIDTH, 140);
    } else {
        return CGSizeMake((SCR_WIDTH - 40) / 2.0, 312);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
   if (section == 0) { // 一条
        return UIEdgeInsetsZero;
    } else { // 块
        return UIEdgeInsetsMake(10, 15, 10, 15);
    }
}

// 头视图的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(0, 167 + 20);
    } else {
        return CGSizeZero;
    }
}





@end
