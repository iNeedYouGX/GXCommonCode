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
        _dataArr = @[@{@"title" : @"alert弹框",
                       @"control" : @"AlertViewTEST"
                       },
                     @{@"title" : @"menuController的使用",
                       @"control" : @"MenuController"
                       },
                     @{@"title" : @"图片的圆角",
                       @"control" : @"GXCircleImageController"
                       },
                     @{@"title" : @"其他窗口的创建",
                       @"control" : @"GXTopWindowsController"
                       },
                     @{@"title" : @"小方块的创建",
                       @"control" : @"GXSquareController"
                       },
                     @{@"title" : @"发段子",
                       @"control" : @"GXPostWordController"
                       }];
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
    cell.textLabel.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class currentClass = NSClassFromString([self.dataArr[indexPath.row] objectForKey:@"control"]);
    if ([NSStringFromClass(currentClass) isEqualToString:@"GXSquareController"]) {
        UITableViewController *vc = [[currentClass alloc] initWithStyle:UITableViewStyleGrouped];
        vc.title =  self.dataArr[indexPath.row][@"title"];
        [self setHidesBottomBarWhenPushed:YES]; // 将tabbar隐藏
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIViewController *vc = [[currentClass alloc] init];
        vc.title =  self.dataArr[indexPath.row][@"title"];
        [self setHidesBottomBarWhenPushed:YES];// 将tabbar隐藏
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self setHidesBottomBarWhenPushed:NO]; // 将tabbar显示
    // 这个方法, 判断具体的选中的行
    NSIndexPath *index = [tableView indexPathForSelectedRow];
    NSLog(@"标题: %@ --- 控制器: %@", self.dataArr[index.row][@"title"], self.dataArr[index.row][@"control"]);
}

@end
