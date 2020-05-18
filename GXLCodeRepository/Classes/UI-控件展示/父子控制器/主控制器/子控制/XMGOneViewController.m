//
//  XMGOneViewController.m
//  01-自定义控制器的切换
//
//  Created by xiaomage on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGOneViewController.h"

@interface XMGOneViewController ()
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation XMGOneViewController
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[
            @{@"title" : @"三方WMPageController",
              @"control" : @"GX_WMPageController"
            },
            @{@"title" : @"网易新闻首页",
              @"control" : @"GXHomeViewController"
            },
                     ];
    }
    return _dataArr;
}
NSString *ID = @"one";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];

    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

- (void)dealloc
{
    NSLog(@"XMGOneViewController --- dealloc");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.textLabel.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     Class currentClass = NSClassFromString([self.dataArr[indexPath.row] objectForKey:@"control"]);
     UIViewController *vc = [[currentClass alloc] init];
     vc.title =  self.dataArr[indexPath.row][@"title"];
     [vc setHidesBottomBarWhenPushed:YES];
     [self.navigationController pushViewController:vc animated:YES];
     // 这个方法, 判断具体的选中的行
     NSIndexPath *index = [tableView indexPathForSelectedRow];
     NSLog(@"标题: %@ --- 控制器: %@", self.dataArr[index.row][@"title"], self.dataArr[index.row][@"control"]);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%s", __func__);
}
@end
