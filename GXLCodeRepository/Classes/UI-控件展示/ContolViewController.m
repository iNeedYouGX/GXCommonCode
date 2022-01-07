//
//  ContolViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/11.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "ContolViewController.h"
#import "AlertViewTEST.h"
#import "MenuController.h"
#import "GXCircleImageController.h"
@interface ContolViewController ()<UITableViewDelegate, UITableViewDataSource>
/** <#注释#> */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation ContolViewController

#pragma mark - Cycle Left
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController setNavigationBarHidden:YES];
    // translucent为YES透明时候0点在0, 0点, 为NO, 0点在0, 64, 他们都自动下调64的, 如果是第一个滚动视图
    [self.navigationController.navigationBar setTranslucent:NO];
    

    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"mainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
    }
    cell.textLabel.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class currentClass = NSClassFromString([self.dataArr[indexPath.row] objectForKey:@"control"]);
    if ([NSStringFromClass(currentClass) isEqualToString:@"GXSquareController"]) {
        UITableViewController *vc = [[currentClass alloc] initWithStyle:UITableViewStyleGrouped];
        vc.title =  self.dataArr[indexPath.row][@"title"];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIViewController *vc = [[currentClass alloc] init];
        vc.title =  self.dataArr[indexPath.row][@"title"];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    // 这个方法, 判断具体的选中的行
    NSIndexPath *index = [tableView indexPathForSelectedRow];
    NSLog(@"标题: %@ --- 控制器: %@", self.dataArr[index.row][@"title"], self.dataArr[index.row][@"control"]);
}

#pragma mark - setter/getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[
            @{@"title" : @"WKWebView使用",
              @"control" : @"GXWKWebViewController"
            },
            @{@"title" : @"各种菜单样式",
              @"control" : @"GXTitlesViewController"
            },
            @{@"title" : @"各种小按钮",
              @"control" : @"GXButtonsViewController"
            },
            @{@"title" : @"UICollectionView使用",
              @"control" : @"GXCollectionViewDemoController"
            },
            @{@"title" : @"CollectionViewCell样式",
              @"control" : @"GXKindsOfViewController"
            },
            @{@"title" : @"UITableView的使用",
              @"control" : @"GXSquareController"
            },
            @{@"title" : @"TableViewCell样式",
              @"control" : @"GXSomeTableCellController"
            },
            @{@"title" : @"弹框Alert样式",
              @"control" : @"AlertViewTEST"
            },
            @{@"title" : @"menuController的创建",
              @"control" : @"MenuController"
            },
            @{@"title" : @"切圆角的方法",
              @"control" : @"GXCircleImageController"
            },
            @{@"title" : @"UIWindow的创建",
              @"control" : @"GXTopWindowsController"
            },
            @{@"title" : @"发段子",
              @"control" : @"GXPostWordController"
            },
            @{@"title" : @"布局",
              @"control" : @"GXFlowLayoutController"
            },
            @{@"title" : @"父子控制器",
              @"control" : @"GXParentChildController"
            },
            @{@"title" : @"RAC的使用",
              @"control" : @"GXRACTestController"
            },
            @{@"title" : @"轮播图使用",
              @"control" : @"GXScrollImageView"
            },
            @{@"title" : @"选择器使用",
              @"control" : @"GXCustomPickerView"
            }
             ];
    }
    return _dataArr;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT - (IsiPhoneX ? (49 + 34) : 49) - (IsiPhoneX ? (44 + 44) : (44 + 20))) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
