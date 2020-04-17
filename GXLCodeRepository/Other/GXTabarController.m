//
//  GXTabarController.m
//  百思不得姐
//
//  Created by JasonBourne on 2018/7/23.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "GXTabarController.h"
#import "ContolViewController.h"
#import "OCExampleController.h"
#import "GXNavigationController.h"
#import "GXFunctionExampleController.h"

@interface GXTabarController ()

@end

@implementation GXTabarController

+ (void)initialize//第一次使用时候
{
    //统一设置
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    // 设置tabbar的背景颜色
    [[UITabBar appearance] setBarTintColor:CZRGBColor(254, 254, 254)];

    // 设配iOS12, tabbar抖动问题
    // Translucent 半透明
    [[UITabBar appearance] setTranslucent:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setupChildVc:[[ContolViewController alloc] init] title:@"UI控件展示" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    [self setupChildVc:[[GXFunctionExampleController alloc] init] title:@"常用功能" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

    [self setupChildVc:[[OCExampleController alloc] init] title:@"OC语法" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    self.selectedIndex = 1;
    
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    // 添加为子控制器
    GXNavigationController *nav = [[GXNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}





@end
