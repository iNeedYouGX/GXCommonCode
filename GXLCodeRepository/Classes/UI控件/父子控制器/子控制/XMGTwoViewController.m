//
//  XMGTwoViewController.m
//  01-自定义控制器的切换
//
//  Created by xiaomage on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTwoViewController.h"

@interface XMGTwoViewController ()

@end

@implementation XMGTwoViewController
- (IBAction)buttonClick:(id)sender {
    NSLog(@"XMGTwoViewController上面的按钮被点击了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    NSLog(@"XMGTwoViewController --- dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
