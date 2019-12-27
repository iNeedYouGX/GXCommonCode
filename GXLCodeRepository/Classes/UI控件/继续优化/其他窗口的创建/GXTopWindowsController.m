//
//  GXTopWindowsController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/24.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXTopWindowsController.h"

@interface GXTopWindowsController ()<UITableViewDelegate, UITableViewDataSource>
/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollerView;
@end

static UIWindow *window_;

@implementation GXTopWindowsController

- (UIScrollView *)scrollerView
{
    if (_scrollerView == nil) {
        self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT - 44)];
        self.scrollerView.backgroundColor = [UIColor greenColor];
        self.scrollerView.pagingEnabled = YES;
    }
    return _scrollerView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    window_.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航不透明, 原点在导航下面
    self.navigationController.navigationBar.translucent = NO;

    // 添加滚动视图
    [self.view addSubview:self.scrollerView];
    
    // 添加两个tableView
    [self setupTableView:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT - 64)];
    [self setupTableView:CGRectMake(SCR_WIDTH, 0, SCR_WIDTH, SCR_HEIGHT - 64)];
    
    // 添加window
    [self setupWindows];
    
    self.scrollerView.contentSize = CGSizeMake(2 * SCR_WIDTH, 0);
}

#pragma mark - 添加一个Windows
- (void)setupWindows
{
    window_ = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 20)];
    window_.backgroundColor = [UIColor grayColor];
    window_.hidden = NO;
    window_.windowLevel = UIWindowLevelAlert;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedTapWindow)];
    [window_ addGestureRecognizer:tap];
}

- (void)didClickedTapWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollerViewInView:window];
}

// 方法递归
- (void)searchScrollerViewInView:(UIView *)superView
{
    for (UIScrollView *scroller in superView.subviews) {
        // scroller.frame 转换到-> [UIApplication sharedApplication].keyWindow 的坐标系, scroller.frame的父视图也得传过来
        //        CGRect newFrame = [scroller.superview convertRect:scroller.frame toView:[UIApplication sharedApplication].keyWindow]; 等同于nil
        
        // 与上面的正好相反
        CGRect newFrame = [[UIApplication sharedApplication].keyWindow convertRect:scroller.frame fromView:scroller.superview];
        CGRect oldFrame = [UIApplication sharedApplication].keyWindow.bounds;
        
        // 判断主窗口的bounds和self的矩形是否有重叠
//        CGRectIntersectsRect(newFrame, oldFrame)
        
        // 判断一个控件是否显示
        BOOL isShowingOnKeyWindow = !scroller.hidden && scroller.alpha > 0.01 && scroller.window && CGRectIntersectsRect(newFrame, oldFrame);
        
        if ([scroller isKindOfClass:[UIScrollView class]] && isShowingOnKeyWindow) {
            CGPoint offset = scroller.contentOffset;
            offset.y = -scroller.contentInset.top;
            [scroller setContentOffset:offset animated:YES];
        }
        // 继续查找子控件
        [self searchScrollerViewInView:scroller];
    }
}

- (void)setupTableView:(CGRect)rect
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.scrollerView addSubview:tableView];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"----我是第%ld个cell", indexPath.row];
    return cell;
}

@end
