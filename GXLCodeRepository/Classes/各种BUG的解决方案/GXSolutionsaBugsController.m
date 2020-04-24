//
//  GXSolutionsaBugsController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/23.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXSolutionsaBugsController.h"

@interface GXSolutionsaBugsController () <UITableViewDelegate, UITableViewDataSource>
/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation GXSolutionsaBugsController

- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[
            @{
                @"title" : @"在iOS13中, 阿里SDK模态的web为PageSheet",
                @"index" : @(0)
             },
            @{
                @"title" : @"最简单的保存图片到手机",
                @"index" : @(1)
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
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
