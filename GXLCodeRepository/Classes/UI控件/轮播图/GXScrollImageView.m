//
//  GXScrollImageView.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/12/21.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXScrollImageView.h"

#import "CZScrollAD.h"
#import "CZScrollADCell.h"
#import "CZScrollADCell1.h"

#import <Masonry.h>

@interface GXScrollImageView () <CZScrollADDelegate>

@end

@implementation GXScrollImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self scrollViewTypeOne];

    [self scrollViewTypeTwo];
}

- (void)scrollViewTypeOne
{
    CGRect frame = CGRectMake(0, 20, SCR_WIDTH, 38);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataSource" ofType:@"json"];
    NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *list = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    CZScrollAD *scollImage = [[CZScrollAD alloc] initWithFrame:frame itemCount:list.count scrollerConfig:^(CZScrollAD * _Nonnull maker) {
        maker.timeInterval = 2;
        maker.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    } registerCell:^(UICollectionView * _Nonnull collectionView) {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CZScrollADCell class]) bundle:nil] forCellWithReuseIdentifier:@"CZScrollADCell"];
    } scrollADCell:^UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
        NSDictionary *model = list[indexPath.item];
        CZScrollADCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CZScrollADCell" forIndexPath:indexPath];
        cell.paramDic = model;
        return cell;
    }];
    [self.view addSubview:scollImage];
    
}

- (void)scrollViewTypeTwo
{
    CGRect frame = CGRectMake(0, 20 + 50, SCR_WIDTH, 55);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataSource1" ofType:@"json"];
    NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *list = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    CZScrollAD *scollImage = [[CZScrollAD alloc] initWithFrame:frame itemCount:list.count scrollerConfig:^(CZScrollAD * _Nonnull maker) {
        maker.timeInterval = 3;
        maker.scrollDirection = UICollectionViewScrollDirectionVertical;
    } registerCell:^(UICollectionView * _Nonnull collectionView) {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CZScrollADCell1 class]) bundle:nil] forCellWithReuseIdentifier:@"CZScrollADCell1"];
    } scrollADCell:^UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
        NSDictionary *model = list[indexPath.item];
        CZScrollADCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CZScrollADCell1" forIndexPath:indexPath];
        cell.paramDic = model;
        return cell;
    }];
    [self.view addSubview:scollImage];

}


@end
