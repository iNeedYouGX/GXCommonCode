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

@interface GXSquareController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation GXSquareController

static NSString *SquareID = @"SquareID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    // 注册tabeleView
    [self.tableView registerClass:[GXSquareCell class] forCellReuseIdentifier:SquareID];
    
    // 调整footer和header
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    // 设置footerView
    self.tableView.tableFooterView = [[GXFooterView alloc] init];
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

#pragma mark - <UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:SquareID];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"tabBar_me_click_icon"];
//        cell.contentView.backgroundColor = [UIColor redColor];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
//        cell.contentView.backgroundColor = [UIColor greenColor];
    }
    return cell;
}
@end
