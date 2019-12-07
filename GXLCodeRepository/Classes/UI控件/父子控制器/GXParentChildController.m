//
//  GXParentChildControllerViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/3/29.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXParentChildController.h"
#import "XMGOneViewController.h"
#import "XMGTwoViewController.h"
#import "XMGThreeViewController.h"

@interface GXParentChildController ()
/** 正在显示的控制器 */
@property (nonatomic, weak) UIViewController *showingVc;

@end

@implementation GXParentChildController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewController:[[XMGOneViewController alloc] init]];
    [self addChildViewController:[[XMGTwoViewController alloc] init]];
    [self addChildViewController:[[XMGThreeViewController alloc] init]];
}

- (IBAction)buttonClick:(UIButton *)button {
    // 获得控制器的位置（索引）
    NSUInteger index = [button.superview.subviews indexOfObject:button];
    // 上一个索引
    NSInteger lastIndex = [self.childViewControllers indexOfObject:self.showingVc];
    if (index == lastIndex) return;

    // 移除其他控制器的view
    [self.showingVc.view removeFromSuperview];

    // 添加控制器的view
    self.showingVc = self.childViewControllers[index];
    self.showingVc.view.frame = CGRectMake(0, 64 + 44, self.view.frame.size.width, self.view.frame.size.height - 64 - 44);
    [self.view addSubview:self.showingVc.view];

    // 添加动画
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    if (index < lastIndex) {
        animation.subtype = kCATransitionFromRight;
    } else {
        animation.subtype = kCATransitionFromLeft;
    }
    //    animation.duration = 1.0;
    [self.view.layer addAnimation:animation forKey:nil];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%s", __func__);
}

@end
