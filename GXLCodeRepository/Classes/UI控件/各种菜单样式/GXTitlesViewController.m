//
//  GXTitlesViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/12/27.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXTitlesViewController.h"
#import "CZTitlesViewTypeLayout.h"
#import "CZCategoryLineLayoutView.h"

@interface GXTitlesViewController ()
/** <#注释#> */
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation GXTitlesViewController

/**
 // 按钮点击变灰
 相关属性：
 @property(nonatomic)         BOOL         reversesTitleShadowWhenHighlighted;  // default is NO. if YES, shadow reverses to shift between engrave and emboss appearance

 @property(nonatomic)         BOOL         adjustsImageWhenHighlighted;   // default is YES. if YES, image is drawn darker when highlighted(pressed) 如果图片还会变灰,这个属性设置NO可以保证图片不变灰

 @property(nonatomic)         BOOL         adjustsImageWhenDisabled;      // default is YES. if YES, image is drawn lighter when disabled

 @property(nonatomic)         BOOL         showsTouchWhenHighlighted;     // default is NO. if YES, show a simple feedback (currently a glow) while highlighted
 */

#pragma mark - 数据
- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"titlesViewDataSource" ofType:@"json"];
        NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *list = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        _dataSource = list;
    }
    return _dataSource;;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self type1];
    [self type2];
    [self type3];
    [self type4];
}

#pragma mark - 创建UI
- (void)type1
{
    CGRect frame = CGRectMake(0, CZGetY([self.view.subviews lastObject]) + 10, SCR_WIDTH, 0);
    CZTitlesViewTypeLayout *line = [[CZTitlesViewTypeLayout alloc] initWithFrame:frame];
    line.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.view addSubview:line];

    [line setBlcok:^(BOOL isLine, BOOL isAsc, NSInteger index) {
        NSLog(@"%d---%d----%ld", isLine, isAsc, index);
    }];
}

- (void)type2
{
    NSArray *list = self.dataSource;
    CGRect frame = CGRectMake(0, CZGetY([self.view.subviews lastObject]) + 10, SCR_WIDTH, 0);
    // 分类的按钮
    NSArray *categoryList = [CZCategoryLineLayoutView categoryItems:list setupNameKey:@"categoryName" imageKey:@"img" IdKey:@"categoryId" objectKey:@""];
    CZCategoryLineLayoutView *categoryView = [CZCategoryLineLayoutView categoryLineLayoutViewWithFrame:frame Items:categoryList type:0 didClickedIndex:^(CZCategoryItem * _Nonnull item) {
        NSLog(@"%@", item.categoryName);
    }];
    categoryView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.view addSubview:categoryView];
}

- (void)type3
{
    NSArray *list = self.dataSource;
    CGRect frame = CGRectMake(0, CZGetY([self.view.subviews lastObject]) + 10, SCR_WIDTH, 0);
    // 分类的按钮
    NSArray *categoryList = [CZCategoryLineLayoutView categoryItems:list setupNameKey:@"categoryName" imageKey:@"img" IdKey:@"categoryId" objectKey:@""];
    CZCategoryLineLayoutView *categoryView = [CZCategoryLineLayoutView categoryLineLayoutViewWithFrame:frame Items:categoryList type:1 didClickedIndex:^(CZCategoryItem * _Nonnull item) {
        NSLog(@"%@", item.categoryName);
    }];
    categoryView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.view addSubview:categoryView];
}


- (void)type4
{
    NSArray *list = self.dataSource;
    CGRect frame = CGRectMake(0, CZGetY([self.view.subviews lastObject]) + 10, SCR_WIDTH, 50);
    // 分类的按钮
    NSArray *categoryList = [CZCategoryLineLayoutView categoryItems:list setupNameKey:@"categoryName" imageKey:@"img" IdKey:@"categoryId" objectKey:@""];
    CZCategoryLineLayoutView *categoryView = [CZCategoryLineLayoutView categoryLineLayoutViewWithFrame:frame Items:categoryList type:2 didClickedIndex:^(CZCategoryItem * _Nonnull item) {
        NSLog(@"%@", item.categoryName);
    }];
    categoryView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.view addSubview:categoryView];
}


@end
