//
//  GXPersonalBlogController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/12.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXPersonalBlogController.h"
#import "GXSolutionsaBugsController.h"
#import "GXNetTool.h"

@interface GXPersonalBlogController ()<UITableViewDelegate, UITableViewDataSource>
/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation GXPersonalBlogController

- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[
            @{
                @"title" : @"Bugs总结",
                @"control" : @"GXSolutionsaBugsController",
            },
            @{
                @"title" : @"常用工具",
                @"control" : @"GXCommonlyUsedToolsController"
            },
        ];
    }
    return _dataArr;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCR_WIDTH, SCR_HEIGHT - (IsiPhoneX ? (49 + 34) : 49)) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建表
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"hotSaleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
    }
    cell.textLabel.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jumpFunction:indexPath.row];
}

- (void)jumpFunction:(NSInteger)index
{
    Class currentClass = NSClassFromString([self.dataArr[index] objectForKey:@"control"]);
    if (currentClass) {
        UIViewController *vc = [[currentClass alloc] init];
        vc.title =  self.dataArr[index][@"title"];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSInteger number = [[self.dataArr[index] objectForKey:@"index"] integerValue];
        switch (number) {
            case 0:
            {
                [CZProgressHUD showProgressHUDWithText:@"添加<UIViewController+LL_Utils.h>文件"];
                [CZProgressHUD hideAfterDelay:3];
                break;
            }
            case 1:
            {
                
                break;
            }
            case 2:
            {
                
                break;
            }
            default:
                break;
        }
    }
}

@end
