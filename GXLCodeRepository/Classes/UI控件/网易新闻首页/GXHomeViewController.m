//
//  GXHomeViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/6/4.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXHomeViewController.h"
#import "XMGSocialViewController.h"

@interface GXHomeViewController () <UIScrollViewDelegate>
/** 标题 */
@property (nonatomic, strong) UIScrollView *titleScrollView;
/** 内容 */
@property (nonatomic, strong) UIScrollView *contentScrollView;
@end

@implementation GXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 添加子控制器
    [self setupChildVc];

    // 创建两个滚动视图
    [self setupBackView];

    // 默认显示第一个
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)setupChildVc
{
    XMGSocialViewController *social0 = [[XMGSocialViewController alloc] init];
    social0.title = @"0-国际";
    [self addChildViewController:social0];

    XMGSocialViewController *social1 = [[XMGSocialViewController alloc] init];
    social1.title = @"1-军事";
    [self addChildViewController:social1];

    XMGSocialViewController *social2 = [[XMGSocialViewController alloc] init];
    social2.title = @"2-社会";
    [self addChildViewController:social2];

    XMGSocialViewController *social3 = [[XMGSocialViewController alloc] init];
    social3.title = @"3-政治";
    [self addChildViewController:social3];

    XMGSocialViewController *social4 = [[XMGSocialViewController alloc] init];
    social4.title = @"4-经济";
    [self addChildViewController:social4];

    XMGSocialViewController *social5 = [[XMGSocialViewController alloc] init];
    social5.title = @"5-体育";
    [self addChildViewController:social5];

    XMGSocialViewController *social6 = [[XMGSocialViewController alloc] init];
    social6.title = @"6-娱乐";
    [self addChildViewController:social6];
}

#pragma mark - 视图
- (void)setupBackView
{
    self.titleScrollView = [[UIScrollView alloc] init];
    self.titleScrollView.backgroundColor = [UIColor redColor];
    self.titleScrollView.x = 0;
    self.titleScrollView.y = 64;
    self.titleScrollView.width = SCR_WIDTH;
    self.titleScrollView.height = 35;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.titleScrollView];

    self.contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView.backgroundColor = [UIColor blueColor];
    self.contentScrollView.x = 0;
    self.contentScrollView.y = CGRectGetMaxY(self.titleScrollView.frame);
    self.contentScrollView.width = SCR_WIDTH;
    self.contentScrollView.height = SCR_HEIGHT - self.contentScrollView.y;
    self.contentScrollView.delegate = self; // 只有内容设置代理
    self.contentScrollView.pagingEnabled = YES;
    [self.view addSubview:self.contentScrollView];

    // 添加标题
    [self setupTitle];
}

// 添加标题
- (void)setupTitle
{

    CGFloat labelY = 0;
    CGFloat labelW = 100;
    CGFloat labelH = self.titleScrollView.height;
    NSInteger count = self.childViewControllers.count;

    for (NSInteger i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%@", self.childViewControllers[i].title];
        label.frame = CGRectMake(100 * i, labelY, labelW, labelH);
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.0  green:arc4random_uniform(100) / 100.0 blue:arc4random_uniform(100) / 100.0 alpha:1];
        [self.titleScrollView addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        if (i == 0) {
            label.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
            label.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
    }
    self.titleScrollView.contentSize = CGSizeMake(labelW * count, 0);
    self.contentScrollView.contentSize = CGSizeMake(SCR_WIDTH * count, 0);
}

- (void)labelClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"%@", tap);
    NSInteger index = tap.view.tag;
    [self.contentScrollView setContentOffset:CGPointMake(index * SCR_WIDTH, 0) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    CGFloat y = 0;
    CGFloat width = scrollView.width;
    CGFloat height = scrollView.height;
    NSInteger index = scrollView.contentOffset.x / scrollView.width;

    // 设置顶部标题居中显示
    UILabel *label = self.titleScrollView.subviews[index];
    CGFloat titleOffsetX = label.centerX - scrollView.width / 2.0;
    // 左边界
    if (titleOffsetX < 0) titleOffsetX = 0;
    // 右边界
    CGFloat maxBorder = self.titleScrollView.contentSize.width - scrollView.width;
    if (titleOffsetX > maxBorder) {
        titleOffsetX = maxBorder;
    }

    // 让其他的label变默认, 如果不写可能有bug
    for (UILabel *subLabel in self.titleScrollView.subviews) {
        if (subLabel == label) break;
        subLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        subLabel.transform = CGAffineTransformMakeScale(1, 1);
    }

    [self.titleScrollView setContentOffset:CGPointMake(titleOffsetX, 0) animated:YES];
    UIViewController *showVc = self.childViewControllers[index];
    showVc.view.frame = CGRectMake(x, y, width, height);
    [scrollView addSubview:showVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.width;
    NSLog(@"scale -- %lf", scale);
    // 左边label
    NSInteger leftIndex = scale;
    UILabel *leftLabel = self.titleScrollView.subviews[leftIndex];

    // 右边label
    if (leftIndex == 6) return;
    NSInteger rightIndex = leftIndex + 1;
    UILabel *rightLabel = self.titleScrollView.subviews[rightIndex];

    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    NSLog(@"rightScale : %lf", rightScale);
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    NSLog(@"leftScale : %lf", leftScale);
      // 右边渐变
    rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    CGFloat transRightSacle = 1 + (rightScale * 0.2);
    rightLabel.transform = CGAffineTransformMakeScale(transRightSacle, transRightSacle);

    // 左边渐变
    CGFloat transLeftScale = 1 + (leftScale * 0.2);
    leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    leftLabel.transform = CGAffineTransformMakeScale(transLeftScale, transLeftScale);
}

@end
