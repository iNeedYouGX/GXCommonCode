//
//  XMGThreeViewController.m
//  01-自定义控制器的切换
//
//  Created by xiaomage on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGThreeViewController.h"

@interface XMGThreeViewController ()

@end

@implementation XMGThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    NSLog(@"XMGThreeViewController --- dealloc");
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%s", __func__);
}

@end
