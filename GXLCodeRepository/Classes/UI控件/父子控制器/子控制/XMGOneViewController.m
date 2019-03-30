//
//  XMGOneViewController.m
//  01-自定义控制器的切换
//
//  Created by xiaomage on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGOneViewController.h"

@interface XMGOneViewController ()

@end

@implementation XMGOneViewController

NSString *ID = @"one";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)dealloc
{
    NSLog(@"XMGOneViewController --- dealloc");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"oneoneone - %zd", indexPath.row];
    return cell;
}
@end
