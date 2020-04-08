//
//  GXButtonsViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/19.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXButtonsViewController.h"
#import "GXButtons.h"

@interface GXButtonsViewController ()

@end

@implementation GXButtonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createType1];
    [self createType2];
    [self createType3];

}

- (void)createType1
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = RANDOMCOLOR;
    [btn setTitle:@"复制评论淘口令" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 150, 36);
    btn.centerX = SCR_WIDTH / 2.0;
    [self.view addSubview:btn];
}

- (void)action:(UIButton *)sender
{
    [CZProgressHUD showProgressHUDWithText:@"action"];
    [CZProgressHUD hideAfterDelay:1.5];
}

- (void)createType2
{
    UIView *currentView = [self.view.subviews lastObject];
    CGFloat y = CZGetY(currentView) + 10;
    GXButtons *btn = [GXButtons buttonWithFrame:CGRectMake(0, y, SCR_WIDTH, 36) title:@"复制评论淘口令" bColor:UIColorFromRGB(0xE25838) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] cornerRadius:5 eventBlock:^(UIButton * _Nonnull btn) {
        NSLog(@"------");
    }];
    [self.view addSubview:btn];
}

- (void)createType3
{
    UIView *currentView = [self.view.subviews lastObject];
    CGFloat y = CZGetY(currentView) + 10;
//    CGRectMake(20, y, 26, 26)
    GXButtons *btn = [GXButtons buttonWithFrame:CGRectMake(20, y, 36, 36) backImage:[UIImage imageNamed:@"nav-back"] bColor:[UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:0.3] cornerRadius:18 eventBlock:^(UIButton * _Nonnull sender) {
        NSLog(@"------");
    }];
    [self.view addSubview:btn];
   

}

@end
