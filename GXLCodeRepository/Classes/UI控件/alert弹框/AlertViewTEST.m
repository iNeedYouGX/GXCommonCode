//
//  AlertViewTEST.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/19.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "AlertViewTEST.h"
#import "CZAlertView1Controller.h"


@interface AlertViewTEST ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>
/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation AlertViewTEST
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    

    // 创建表
    [self.view addSubview:self.tableView];
}


#pragma mark - 创建UI
- (UITableView *)tableView
{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCR_WIDTH, SCR_HEIGHT - (IsiPhoneX ? (44 + 44) : (44 + 20)) - 1) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

#pragma mark - 初始化数据
- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[@""];
    }
    return _dataSource;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"hotSaleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"弹框样式%ld", (indexPath.row + 1)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [CZProgressHUD showProgressHUDWithText:nil];
    } else if (indexPath.row == 1) {
        [CZProgressHUD showProgressHUDWithText:@"弹框样式2"];
    } else if (indexPath.row == 2) {
        [CZProgressHUD showOrangeProgressHUDWithText:@"弹框样式3"];
    } else if (indexPath.row == 3) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"弹框样式4" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    } else if (indexPath.row == 4) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"弹框样式5" preferredStyle:UIAlertControllerStyleActionSheet];
        [alertView addAction:[UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    } else if (indexPath.row == 5) {
        // 此为自定义的ViewController
        CZAlertView1Controller *view = [[CZAlertView1Controller alloc] init];
        // 设定大小(此处也可不做设置,不做设置的效果如下图)
        view.preferredContentSize = CGSizeMake(100, 100);
        // 初始化
        view.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *popVC = view.popoverPresentationController;
        popVC.permittedArrowDirections = UIPopoverArrowDirectionUp; // 箭头位置
        popVC.sourceRect = CGRectMake(0, 0, 50, 0); // 弹出视图显示位置
        // 设置代理
        popVC.delegate = self;
        popVC.sourceView = [self.tableView cellForRowAtIndexPath:indexPath];
        
        // 退出视图
        [self presentViewController:view animated:YES completion:nil];
        
    }
    [CZProgressHUD hideAfterDelay:1.5];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    // 此处为不适配(如果选择其他,会自动视频屏幕,上面设置的大小就毫无意义了)
    return UIModalPresentationNone;
}

@end
