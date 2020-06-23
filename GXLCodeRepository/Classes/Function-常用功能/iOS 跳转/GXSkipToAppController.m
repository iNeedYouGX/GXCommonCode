//
//  GXSkipToAppController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/20.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXSkipToAppController.h"

@interface GXSkipToAppController ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@end

@implementation GXSkipToAppController
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
    [self.view addSubview:self.scrollerView];
    
    [self example1];
    [self example2];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
}

- (void)example1
{
    [GXElementLabel elementLabelMainTitle:@"一. 程序间跳转" containView:self.scrollerView];
    
    NSString *subStr =
    @"知识点回顾\n"
    @"• URL: 统一资源定位符(可以没有path, 但一定要有scheme)\n"
    @"• 组成:\n"
    @"\t • scheme : 协议头, 用来决定查找资源的方式 http:// ftp://\n"
    @"\t • path: 路径";
    [GXElementView elementViewTitle:subStr containView:self.scrollerView];
    
    
    NSString *subStr1 =
    @"正文\n"
    @"• 默认情况下iOS程序是没有URL的, 如果想打开应用程序, 只需要配置一个协议头即可(scheme)\n";
    [GXElementView elementViewTitle:subStr1 containView:self.scrollerView];
    [GXElementView elementViewImage:@"07e63a60eb00dfac.png" containView:self.scrollerView];
    
    
    NSString *subStr2 =
    @"• 能不能打开该url的应用 \n"
    @"if ([[UIApplication sharedApplication] canOpenURL:@""]) { } \n";
    [GXElementView elementViewTitle:subStr2 containView:self.scrollerView];
    
    
    NSString *subStr3 =
    @"• 打开该url的应用 iOS10 弃用了 \n"
    @"[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@\"hahaha:\"]];";
    [GXElementView elementViewTitle:subStr3 containView:self.scrollerView];
    
    
    NSString *subStr4 =
    @"• 打开该url的应用 最新 \n"
    @"[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@\"hahaha:\"] options:@{} completionHandler:^(BOOL success) { \n"
    @" NSLog(@\"%d\", success); \n"
    @"}];";
    [GXElementView elementViewTitle:subStr4 containView:self.scrollerView];
    
    
    NSString *subStr5 =
    @"• 在AppDelegate中监听某人打开自己项目时候传入的参数 \n"
    @"- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options \n"
    @"{ \n"
    @"\t NSString *urlPath = url.absoluteString; \n"
    @"\t if ([urlPath containsString:@\"打开某某界面\"]) { \n\n\t} \n"
    @"\t return YES; \n"
    @"}";
    [GXElementView elementViewTitle:subStr5 containView:self.scrollerView];
}

- (void)example2
{
    [GXElementLabel elementLabelMainTitle:@"二. 跳转系统界面" containView:self.scrollerView];
    
    NSString *subStr1 =
    @"1. 打电话 \n"
    @"NSString * str = @\"tel:0571-88120907\"; \n"
    @"[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];";
    [GXElementView elementViewTitle:subStr1 containView:self.scrollerView];
    
    NSString *subStr2 =
    @"2. 跳转到评分 \n"
    @"NSString * str = @\"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1450707933&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8\";";
    [GXElementView elementViewTitle:subStr2 containView:self.scrollerView];
    
    NSString *subStr3 =
    @"3. 跳转到应用详情页 \n"
    @"NSString * str = @\"https://itunes.apple.com/cn/app/id1450707933?mt=8\n"
    @"NSString * str = @\"itms-apps://itunes.apple.com/cn/app/id1450707933?mt=8\n"
    @"其中参数mt:8的含义为：mt 代表 meta-type，有效值如下：\n"
    @"1 Music\n"
    @"2 Podcasts\n"
    @"3 Audiobooks\n"
    @"4 TV Shows\n"
    @"5 Music Videos\n"
    @"6 Movies\n"
    @"7 iPod Games\n"
    @"8 Mobile Software Applications\n"
    @"9 Ringtones\n"
    @"10 iTunes U\n"
    @"11 E-Books\n"
    @"12 Desktop Apps\n";
    [GXElementView elementViewTitle:subStr3 containView:self.scrollerView];
    
    
    NSString *subStr4 =
    @"3. 跳转到设置权限, 通知, 无线网 \n"
    @"NSString * str = UIApplicationOpenSettingsURLString;";
    [GXElementView elementViewTitle:subStr4 containView:self.scrollerView];
    
    

}

@end
