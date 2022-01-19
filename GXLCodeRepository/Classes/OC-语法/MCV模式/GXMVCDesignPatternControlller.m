//
//  GXMVCDesignPatternControlller.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/6/19.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXMVCDesignPatternControlller.h"
#import "GXNetTool.h"

@interface GXMVCDesignPatternControlller () <UITableViewDelegate, UITableViewDataSource>
/** 表单 */
@property (nonatomic, strong) UITableView *tableView;
/** 页数 */
@property (nonatomic, assign) NSInteger page;

/** <#注释#> */
@property (nonatomic, strong) NSString *model;

/** <#注释#> */
@property (nonatomic, strong) UILabel *label;

/** <#注释#> */
@property (nonatomic, strong) UIButton *btn;
@end

@implementation GXMVCDesignPatternControlller

#pragma mark Cycle Lift
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    
    [self.view addSubview:self.btn];
    
    [self addObserver:self forKeyPath:@"self.model" options:NSKeyValueObservingOptionNew context:nil];
    
     // 创建表
    [self.view addSubview:self.tableView];
    
    [self setupRefresh];
    
}

#pragma mark - Layout subViews
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNewTrailDataSorce)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTrailDataSorce)];
}

#pragma mark - getData
- (void)reloadNewTrailDataSorce
{
    // 结束尾部刷新
    [self.tableView.mj_footer endRefreshing];
    self.page = 1;
    //获取数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"status"] = @(0);
    param[@"page"] = @(self.page);
    [GXNetTool GetNetWithUrl:[@"" stringByAppendingPathComponent:@"api/my/trial/list"] body:param header:nil response:GXResponseStyleJSON success:^(id result) {
        if ([result[@"code"] isEqual:@(0)]) {
            
            
            
            [self.tableView reloadData];
        }
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        //隐藏菊花
        [CZProgressHUD hideAfterDelay:0];
    } failure:^(NSError *error) {}];
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
    [GXNetTool GetNetWithUrl:[@"" stringByAppendingPathComponent:@"api/my/trial/list"] body:param header:nil response:GXResponseStyleJSON success:^(id result) {
        if ([result[@"code"] isEqual:@(0)]) {
            
            
            [self.tableView reloadData];
        }
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        //隐藏菊花
        [CZProgressHUD hideAfterDelay:0];
    } failure:^(NSError *error) {}];
}


#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 161;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"hotSaleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"-----%ld", indexPath.row];
    return cell;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@----%@", keyPath, change);
    self.label.text = self.model;
    [_label sizeToFit];
}

#pragma mark - Method
- (void)changeText:(UIButton *)sender
{
    NSLog(@"-----------");
    self.model = [NSString stringWithFormat:@"%u", arc4random() % 100];
}

#pragma mark - getter/setter
- (UIButton *)btn
{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.y = 200;
        _btn.x = 100;
        [_btn setTitle:@"改变文字" forState:UIControlStateNormal];
        [_btn setTitleColor:RANDOMCOLOR forState:UIControlStateNormal];
        [_btn setBackgroundColor:RANDOMCOLOR];
        [_btn sizeToFit];
        [_btn addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = RANDOMCOLOR;
        _label.x = 100;
        _label.y = 100;
        [_label sizeToFit];
    }
    return _label;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCR_WIDTH, SCR_HEIGHT - ((IsiPhoneX ? 24 : 0) + 67.7) - 50 - 1) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
