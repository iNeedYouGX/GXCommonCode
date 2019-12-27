//
//  GXKindsOfViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/12/27.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXKindsOfViewController.h"
#import "CZFestivalGoodsColLayoutView.h"

@interface GXKindsOfViewController ()

@end

@implementation GXKindsOfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    [self createUI];
}

- (void)createUI
{
    CGRect frame = CGRectMake(0, 20, SCR_WIDTH, 167 + 20);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KindsOfViewData" ofType:@"json"];
    NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *list = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:frame];
    scrollerView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.view addSubview:scrollerView];
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
}

@end
