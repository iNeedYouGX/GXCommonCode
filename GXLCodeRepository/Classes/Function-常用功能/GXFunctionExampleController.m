//
//  GXFunctionExampleController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/19.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXFunctionExampleController.h"
#import "GXNetTool.h"
#import "GXShareToSocial.h"
#import "GXSaveImageToPhone.h"
#import "GXAVPlayerViewController.h"
@interface GXFunctionExampleController () <UITableViewDelegate, UITableViewDataSource>
/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation GXFunctionExampleController
#pragma mark - 数据
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[
            @{
                @"title" : @"系统分享",
                @"index" : @(0)
             },
            @{
                @"title" : @"保存图片",
                @"index" : @(1)
            },
            @{
                @"title" : @"输出图片",
                @"control" : @"GXOutputImageController",
            },
            @{
                @"title" : @"复制",
                @"index" : @(2)
            },
            @{
                @"title" : @"AVPlayer简单使用",
                @"control" : @"GXAVPlayerViewController",
            },
            @{
                @"title" : @"改变图片颜色",
                @"control" : @"GXImageHandler",
            },
            @{
                @"title" : @"阴影设置",
                @"control" : @"GXShadowHandler",
            },
            @{
                @"title" : @"iOS跳转",
                @"control" : @"GXSkipToAppController",
            },
            @{
                @"title" : @"iOS退出",
                @"control" : @"GXExitApplicationController",
            },
                     ];
    }
    return _dataArr;
}

#pragma mark - 创建UI
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

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建表
    [self.view addSubview:self.tableView];
}

#pragma mark - 代理
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
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 15];
    }
    cell.textLabel.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    return cell;
}

#pragma mark - cell的跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jumpFunction:indexPath.row];
}

#pragma mark - 跳转到指定也面
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
            case 0: // 分享
            {
                [self share];
                break;
            }
            case 1: // 保存图片
            {
                [self saveImage];
                break;
            }
            case 2: // 复制到剪切板
            {
                [self generalPaste];
                break;
            }
            default:
                break;
        }
    }
}


#pragma mark - 简单的功能
/** 复制到剪切板 */
- (void)generalPaste
{
    UIPasteboard *posteboard = [UIPasteboard generalPasteboard];
    posteboard.string = @"";
    [CZProgressHUD showProgressHUDWithText:@"复制成功"];
    [CZProgressHUD hideAfterDelay:1.5];
}

/** 分享 */
- (void)share
{
    [GXShareToSocial shareToSocial];
}

/** 保存图片 */
- (void)saveImage
{
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 2; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        [images addObject:image];
    }
    [GXSaveImageToPhone saveBatchImage:images];
}



@end
