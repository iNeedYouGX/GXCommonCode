//
//  CZScrollAD.h
//  BestCity
//
//  Created by JasonBourne on 2019/12/20.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN
@protocol CZScrollADDelegate <NSObject>
@optional
- (UICollectionViewCell *)scrollADView:(UICollectionView *)scrollAD cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CZScrollAD : UIView

@property (nonatomic, weak) id <CZScrollADDelegate> delegate;
/** 通过注册CollectionCell方式无线滚动 */
- (instancetype)initWithFrame:(CGRect)frame dataSourceList:(NSArray *)dataSourceList scrollerConfig:(void (^)(CZScrollAD *maker))configBlock registerCell:(void (^)(UICollectionView *))registerCellBlock scrollADCell:(UICollectionViewCell * (^)(UICollectionView *collectionView, NSIndexPath *indexPath))scrollADBlock;

/** 设置轮播图的时间间隔 */
@property (nonatomic, assign) NSTimeInterval timeInterval;
/** 滚动方向 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@end

NS_ASSUME_NONNULL_END

