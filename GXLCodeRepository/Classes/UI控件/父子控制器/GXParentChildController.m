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

/** 存放所有控制器的数组 */
@property (nonatomic, strong) NSArray *allVces;
@end

@implementation GXParentChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allVces = @[
                     [[XMGOneViewController alloc] init],
                     [[XMGTwoViewController alloc] init],
                     [[XMGThreeViewController alloc] init]
                     ];
}

- (IBAction)buttonClick:(UIButton *)button {
    // 移除其他控制器的view
    [self.showingVc.view removeFromSuperview];
    
    // 获得控制器的位置（索引）
    NSUInteger index = [button.superview.subviews indexOfObject:button];
    
    // 添加控制器的view
    self.showingVc = self.allVces[index];
    self.showingVc.view.frame = CGRectMake(0, 64 + 44, self.view.frame.size.width, self.view.frame.size.height - 64 - 44);
    [self.view addSubview:self.showingVc.view];
}

@end
