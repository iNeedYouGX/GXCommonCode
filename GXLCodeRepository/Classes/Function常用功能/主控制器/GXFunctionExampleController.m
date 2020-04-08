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

@interface GXFunctionExampleController () <UITableViewDelegate, UITableViewDataSource>
/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation GXFunctionExampleController

- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[
            @{@"title" : @"系统自带的分享",
              @"index" : @(0)
            },
            @{@"title" : @"最简单的保存图片到手机",
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
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self.dataArr[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger number = [self.dataArr[indexPath.row][@"index"] integerValue];
    [self jumpFunction:number];
}

- (void)jumpFunction:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [GXShareToSocial shareToSocial];
            break;
        }
        case 1:
        {
            for (int i = 1; i < 21; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
                [GXSaveImageToPhone saveBatchImage:image];
            }
            break;
        }
        default:
            break;
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



@end
