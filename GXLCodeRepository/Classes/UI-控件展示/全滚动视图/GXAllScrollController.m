//
//  GXAllScrollController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2021/3/23.
//  Copyright © 2021 JasonBourne. All rights reserved.
//

#import "GXAllScrollController.h"

#import "GXNetTool.h"
#import "CZCZFreeChargeCell2.h"
#import "CZMHSDCommodityCell.h"
#import "CZMHSDCommodityCell2.h"

@interface GXAllScrollController () <UITableViewDelegate, UITableViewDataSource>
/** <#注释#> */
@property (nonatomic, strong) UIScrollView *contentView;
/** <#注释#> */
@property (nonatomic, strong) UIView *headerView;




/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 页数 */
@property (nonatomic, assign) NSInteger page;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation GXAllScrollController
- (UIScrollView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
        _contentView.backgroundColor = [UIColor grayColor];
    }
    return _contentView;
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 200)];
        _headerView.backgroundColor = [UIColor greenColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headDefault"]];
        imageView.frame = CGRectMake(0, 0, SCR_WIDTH, 200);
        imageView.contentMode = UIViewContentModeScaleToFill;
        [_headerView addSubview:imageView];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.contentView];
    
    [self.view addSubview:self.headerView];
    
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCR_WIDTH, SCR_HEIGHT - (IsiPhoneX ? (44 + 44) : (44 + 20)) - 1) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNewTrailDataSorce)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTrailDataSorce)];
}

#pragma mark - 获取数据
- (void)reloadNewTrailDataSorce
{
    // 结束尾部刷新
    [self.tableView.mj_footer endRefreshing];
    self.page = 1;
    //获取数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"status"] = @(0);
    param[@"page"] = @(self.page);

    // 获取数据
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"SomeTableCellDataSource.json" withExtension:@""];
    [GXNetTool GetNetWithUrl:url.absoluteString body:param header:nil response:GXResponseStyleJSON success:^(id result) {
        if ([result[@"code"] isEqual:@(0)]) {
            self.dataSource = [NSMutableArray arrayWithArray: result[@"data"]];
            [self.tableView reloadData];
        }
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTrailDataSorce
{
    // 先结束头部刷新
    [self.tableView.mj_header endRefreshing];
    self.page++;
    //获取数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"status"] = @(0);
    param[@"page"] = @(self.page);

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"SomeTableCellDataSource.json" withExtension:@""];
    [GXNetTool GetNetWithUrl:url.absoluteString body:param header:nil response:GXResponseStyleJSON success:^(id result) {
        if ([result[@"code"] isEqual:@(0)]) {
            NSArray *arr = result[@"data"];
//            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
        }
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 290;
    } else {
        return 140;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CZCZFreeChargeCell2 *cell = [CZCZFreeChargeCell2 cellWithTableView:tableView];
        cell.model = self.dataSource[indexPath.row];
        return cell;
    } else if (indexPath.row == 1) {
        CZMHSDCommodityCell *cell = [CZMHSDCommodityCell cellwithTableView:tableView];
        cell.dataDic = self.dataSource[indexPath.row];
        cell.indexNumber = indexPath.row;
        return cell;
    } else if (indexPath.row == 2) {
        CZMHSDCommodityCell2 *cell = [CZMHSDCommodityCell2 cellwithTableView:tableView];
        cell.dataDic = self.dataSource[indexPath.row];
        return cell;
    } else {
        static NSString *ID = @"hotSaleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"-----%ld", indexPath.row];
        return cell;
    }
}



@end
