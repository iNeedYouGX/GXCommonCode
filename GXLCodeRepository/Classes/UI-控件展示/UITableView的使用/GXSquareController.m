//
//  GXSquareController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/25.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXSquareController.h"
#import "GXSquareCell.h"
#import "GXFooterView.h"

@interface GXSquareController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GXSquareController

static NSString *SquareID = @"SquareID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    // 注册tabeleView
    [self.tableView registerClass:[GXSquareCell class] forCellReuseIdentifier:SquareID];
    // 注册tableViewHeaderView
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"sectionHeaderView"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"sectionFooterView"];

    // UITableView的常见设置
    // 分割线颜色
    self.tableView.separatorColor = [UIColor redColor];
    // 隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    // 调整footer和header
    self.tableView.sectionHeaderHeight = 35;
    self.tableView.sectionFooterHeight = 35;

    // 设置footerView
    self.tableView.tableFooterView = [[GXFooterView alloc] init];
    self.tableView.tableHeaderView = [[GXFooterView alloc] init];

    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:SquareID];
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld个section的第%ld个cell", indexPath.section, indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"tabBar_me_click_icon"];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld个section的第%ld个cell", indexPath.section, indexPath.row];;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeaderView"];
    sectionHeaderView.contentView.backgroundColor = [UIColor purpleColor];
    sectionHeaderView.height = tableView.sectionFooterHeight;
    
    UILabel *label = [sectionHeaderView viewWithTag:100];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = 100;
        label.font = [UIFont systemFontOfSize:14 weight:2.0];
        [sectionHeaderView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"我是第%ld个section的HeaderInSection", section];
    [label sizeToFit];
    label.centerY = tableView.sectionHeaderHeight / 2.0;

    return sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionFooterView"];
    sectionFooterView.contentView.backgroundColor = [UIColor orangeColor];
    sectionFooterView.height = tableView.sectionFooterHeight;

    UILabel *label = [sectionFooterView viewWithTag:100];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = 100;
        label.font = [UIFont systemFontOfSize:14 weight:2.0];
        [sectionFooterView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"我是第%ld个section的FooterInSection", section];
    [label sizeToFit];
    label.centerY = tableView.sectionHeaderHeight / 2.0;

    return sectionFooterView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
@end
