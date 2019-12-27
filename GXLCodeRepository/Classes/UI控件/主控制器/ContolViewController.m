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
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation ContolViewController

- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[@{@"title" : @"弹框的创建",
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
                     @{@"title" : @"UITableView的创建",
                       @"control" : @"GXSquareController"
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
                     @{@"title" : @"网易新闻首页",
                       @"control" : @"GXHomeViewController"
                       },
                     @{@"title" : @"RAC的使用",
                       @"control" : @"GXRACTestController"
                        },
                     @{@"title" : @"轮播图使用",
                       @"control" : @"GXScrollImageView"
                        },
                     @{@"title" : @"各种菜单样式",
                       @"control" : @"GXTitlesViewController"
                     },
                     @{@"title" : @"各种UI样式-单独的View",
                       @"control" : @"GXKindsOfViewController"
                     }
                     ];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UITableView *tableView =[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
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

@end
