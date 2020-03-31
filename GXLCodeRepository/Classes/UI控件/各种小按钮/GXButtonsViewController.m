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

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, CZGetY(backView), 150, 36);
//    btn.centerX = SCR_WIDTH / 2.0;
//    [self.view addSubview:btn];
//    [btn setTitle:@"复制评论淘口令" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.backgroundColor = CZREDCOLOR;
//    btn.layer.cornerRadius = 5;
//    [btn addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
    GXButtons *btn = [GXButtons buttonWithFrame:CGRectMake(20, 20, 150, 36) title:@"复制评论淘口令" bColor:UIColorFromRGB(0xE25838) color:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] cornerRadius:5 eventBlock:^(UIButton * _Nonnull btn) {
        NSLog(@"------");
    }];
    [self.view addSubview:btn];
   
}



@end
