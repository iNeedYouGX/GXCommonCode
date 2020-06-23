//
//  OCExampleController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/11.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "OCExampleController.h"

@interface OCExampleController ()<UITableViewDelegate, UITableViewDataSource>
/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;
/** 数组 */
@property (nonatomic, strong) NSMutableArray *viewsArr;
@end

@implementation OCExampleController
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = @[
            @{
                @"title" : @"结构体的创建",
                @"index" : @(0)
            },
            @{
                @"title" : @"数组方法",
                @"control" : @"GXArrayFunctionController",
            },
            @{
                @"title" : @"字符串方法",
                @"control" : @"GXStringFunctionController",
            },
            @{
                @"title" : @"富文本方法",
                @"control" : @"GXAttrStringFuncController",
            },
            @{
                @"title" : @"链式编程",
                @"control" : @"GXChainProgrammingControlller",
            },
            @{
                @"title" : @"MVC设计模式",
                @"control" : @"GXMVCDesignPatternControlller",
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

// 初始化
- (NSMutableArray *)viewsArr
{
    if (_viewsArr == nil) {
        _viewsArr = [NSMutableArray array];
    }
    return _viewsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建表
    [self.view addSubview:self.tableView];
    
    NSString *str = @"";
    
//    将string字符串转换为array数组
     NSArray  *array = [str componentsSeparatedByString:@","]; // --分隔符

//    将array数组转换为string字符串
     NSString *str1 = [array componentsJoinedByString:@","]; // --分隔符
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
                [self example1];
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

#pragma mark - 结构体的创建
- (void)example1
{
    struct GXRect {
        CGFloat x;
        CGFloat y;
        CGFloat w;
        CGFloat h;
    };
    
    typedef struct GXRect GXRect;
    GXRect rect = {1, 1, 1, 2};
    
    NSLog(@"%lf", rect.x);
    
}

@end
