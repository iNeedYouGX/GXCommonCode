//
//  GXSolutionsaBugsController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/23.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXSolutionsaBugsController.h"

@interface GXSolutionsaBugsController ()

@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation GXSolutionsaBugsController

- (UIScrollView *)scrollerView
{
    if (_scrollerView == nil) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
        //    scrollerView.backgroundColor = RANDOMCOLOR;
        _scrollerView.pagingEnabled = NO;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollerView];
    
    [self example1];
    [self example2];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
}

- (void)example1
{
    NSString *subStr1 = @"1. 在iOS13中, 修改阿里SDK模态的webView的弹出模式PageSheet为FullScreen \n 添加<UIViewController+LL_Utils.h>文件";
    [GXElementView elementViewTitle:subStr1 containView:self.scrollerView];
    
    NSString *subStr2 = @"2. MRC导入ARC模式 添加-fno-objc-arc";
    [GXElementView elementViewTitle:subStr2 containView:self.scrollerView];
    
    NSString *subStr3 = @"3. 设置属性如果没反应, 一定是没初始化";
    [GXElementView elementViewTitle:subStr3 containView:self.scrollerView];
    
    NSString *subStr4 = @"4. 重写父类方法, 可以解决很多问题";
    [GXElementView elementViewTitle:subStr4 containView:self.scrollerView];
    
    NSString *subStr5 = @"5. 同时重写setter 和 getter 时, 系统不会自动创建 实例变量, 要通过@synthesize name = _name声明实例变量";
    [GXElementView elementViewTitle:subStr5 containView:self.scrollerView];
    
    NSString *subStr6 = @"6. 想要改变 UITabBarItem 的图片大小 \n"
    @" • 更改图片名字 如: dog@3x.png \n"
    @" • 用 - (void) drawRect:(CGRect)rect 方法从写 \n"
    @" • 注: 修改imageInsets不起作用";
    [GXElementView elementViewTitle:subStr6 containView:self.scrollerView];
    
    NSString *subStr7 = @"7. indexPath比较大小时, 4S中比较会有问题";
    [GXElementView elementViewTitle:subStr7 containView:self.scrollerView];
    
    NSString *subStr8 = @"8. 若果scrollerView, 默认向下便宜 \n"
    @"if (@available(iOS 11.0, *)) {"
    @"\t UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; \n"
    @"} else { \n"
    @"\t self.automaticallyAdjustsScrollViewInsets = NO; \n"
    @"}";
    [GXElementView elementViewTitle:subStr8 containView:self.scrollerView];
    
    NSString *subStr9 = @"9. 跳转手淘sdk后点击“返回”小把手无法返回app \n"
    @"解决：AlibcTradeShowParams对象的backUrl属性不要进行设置";
    [GXElementView elementViewTitle:subStr9 containView:self.scrollerView];
    
    
}

- (void)example2
{
    
}


@end
