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
   
    [self.navigationBar setTranslucent:NO];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
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
