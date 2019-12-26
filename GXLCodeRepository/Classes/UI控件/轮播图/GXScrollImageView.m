//
//  GXScrollImageView.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/12/21.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXScrollImageView.h"
#import "CZScollerImageTool.h"

#import "CZScrollAD.h"
#import "CZScrollADCell.h"
#import "CZScrollADCell1.h"


@interface GXScrollImageView () <CZScrollADDelegate>

@end

@implementation GXScrollImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self scrollViewTypeOne];

    [self scrollViewTypeTwo];

    [self scrollViewTypeThree];

}

// 跑马灯样式
- (void)scrollViewTypeOne
{
    CGRect frame = CGRectMake(0, 20, SCR_WIDTH, 38);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataSource" ofType:@"json"];
    NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *list = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    CZScrollAD *scollImage = [[CZScrollAD alloc] initWithFrame:frame dataSourceList:list scrollerConfig:^(CZScrollAD * _Nonnull maker) {
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

// 自定义cell轮播
- (void)scrollViewTypeTwo
{
    CGRect frame = CGRectMake(0, 20 + 50, SCR_WIDTH, 55);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataSource1" ofType:@"json"];
    NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *list = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    CZScrollAD *scollImage = [[CZScrollAD alloc] initWithFrame:frame dataSourceList:list scrollerConfig:^(CZScrollAD * _Nonnull maker) {
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

// 常规的一张图片轮播
- (void)scrollViewTypeThree
{
    CGRect frame = CGRectMake(0, CZGetY([self.view.subviews lastObject]) + 10, SCR_WIDTH, 170);
    NSArray *list = @[
        @"http://jipincheng.cn/activity/img/20191118/9bb328bcbfa1478386c77e039cd35d72",
        @"http://jipincheng.cn/activity/img/20191118/d4500fd4b4544befa7fa5b1261b20d68",
        @"http://jipincheng.cn/activity/img/20191118/24157b27736b4379b6136788ec80997e",
        @"http://jipincheng.cn/activity/img/20191118/c8da99525cff4c209699c9b4fd57aed2",
    ];
    CZScollerImageTool *imageView = [[CZScollerImageTool alloc] initWithFrame:frame];
    imageView.imgList = list;
    [self.view addSubview:imageView];
}


@end
