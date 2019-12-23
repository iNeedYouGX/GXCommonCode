//
//  CZScrollAD.m
//  BestCity
//
//  Created by JasonBourne on 2019/12/20.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "CZScrollAD.h"
#import "CZScrollADCell.h"
#import "CZScrollADCell1.h"

@interface CZScrollAD () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
/** <#注释#> */
@property (nonatomic, strong) NSTimer *timer;
/** <#注释#> */
@property (nonatomic, strong) UICollectionViewCell * (^scrollADBlock)(UICollectionView *, NSIndexPath *);
/** <#注释#> */
@property (nonatomic, strong) Class cellClass;

/** <#注释#> */
@property (nonatomic, assign) NSInteger itemCount;

@end

@implementation CZScrollAD
#pragma mark -- xib创建时候使用的
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self creatrUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


#pragma mark - 正常便利构造创建
- (instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)count scrollerConfig:(void (^)(CZScrollAD *maker))configBlock registerCell:(void (^)(UICollectionView *))registerCellBlock scrollADCell:(UICollectionViewCell * (^)(UICollectionView *collectionView, NSIndexPath *indexPath))scrollADBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        configBlock(self);
        self.itemCount = count;
        self.scrollADBlock = scrollADBlock;
        registerCellBlock(self.collectionView);
        [self creatrUI];
    }
    return self;
}




- (void)creatrUI
{
    [self addSubview:self.collectionView];
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:100 / 2] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    [self.timer fire];
}

-(UICollectionView *)collectionView{

    if (!_collectionView ) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
        flowLayout.sectionInset  = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = self.scrollDirection;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
    }
    return  _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 100;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = self.scrollADBlock(collectionView, indexPath);
    return cell;
}

#pragma mark - 创建定时器
- (NSTimer *)timer
{
    if (_timer == nil ) {
        NSTimeInterval interval;
        if (_timeInterval > 0) {
            interval = _timeInterval;
        } else {
            interval = 2.0;
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)nextpage
{
    if (self.itemCount > 0) {
        // 获取当前的indexPath.item
        NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];

        NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:100 / 2];

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        } else {
            [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        }

        NSInteger nextItem = currentIndexPathReset.item + 1;
        NSInteger nextSection = currentIndexPathReset.section;
        if (nextItem == self.itemCount) {
            nextItem = 0;
            nextSection++;
        }
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        } else {
            [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        }
    }
}
@end
