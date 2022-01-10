//
//  GXNavigationController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/11/7.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXNavigationController.h"

@interface GXNavigationController ()

@end

@implementation GXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark - 解决视图刚加载完, 导航栏不显示问题
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *scrollEdge = [[UINavigationBarAppearance alloc] init];
        scrollEdge.backgroundColor = UIColor.whiteColor;
        
        UINavigationBarAppearance *standard = [[UINavigationBarAppearance alloc] init];
        standard.backgroundColor = UIColor.greenColor;
        
        //        UINavigationBar *navigationBar = [UINavigationBar appearance];
        // 没滚动时候
        self.navigationBar.scrollEdgeAppearance = scrollEdge;
        // 滚动时候, 不设置毛玻璃效果
//        self.navigationBar.standardAppearance = standard;
    }
#pragma mark - end
   
    [self.navigationBar setTranslucent:NO];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
//        self.navigationBar.prefersLargeTitles = YES;
    } else {
       // Fallback on earlier versions
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
