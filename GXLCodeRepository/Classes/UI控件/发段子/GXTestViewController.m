//
//  GXTestViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/12/12.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXTestViewController.h"

@interface GXTestViewController ()
/** <#注释#> */
@property (nonatomic, strong) UIView *v1;
@property (nonatomic, strong) UIView *v2;
@property (nonatomic, strong) UIView *v3;
@end

@implementation GXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    
    //以监听UIApplicationDidChangeStatusBarOrientationNotification通知为例
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleStatusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

//界面方向改变的处理
- (void)handleStatusBarOrientationChange: (NSNotification *)notification{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
        case UIInterfaceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIInterfaceOrientationPortrait:
            NSLog(@"界面直立");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"界面直立，上下颠倒");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"界面朝左");
            [self.view layoutIfNeeded];
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"界面朝右");
            break;
        default:
            break;
    }
}

- (void)setupView
{
    self.v1 = [[UIView alloc] init];
    _v1.backgroundColor = [UIColor redColor];
    self.v2 = [[UIView alloc] init];
    _v2.backgroundColor = [UIColor yellowColor];
    self.v3 = [[UIView alloc] init];
    _v3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_v1];
    [self.view addSubview:_v2];
    [self.view addSubview:_v3];
}

- (void)viewWillLayoutSubviews
{
    NSLog(@"%f", self.view.frame.size.width);
    CGFloat width = self.view.size.width;
    CGFloat height = self.view.size.height / 3.0;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.v1.frame = CGRectMake(0, 0, width / 3.0, height * 3.0);
        self.v2.frame = CGRectMake(CGRectGetMaxX(self.v1.frame), 0, width / 3.0, height * 3.0);
        self.v3.frame = CGRectMake(CGRectGetMaxX(self.v2.frame), 0, width / 3.0, height * 3.0);
    } else {
        self.v1.frame = CGRectMake(0, 0, width, height);
        self.v2.frame = CGRectMake(0, CGRectGetMaxY(self.v1.frame), width, height);
        self.v3.frame = CGRectMake(0, CGRectGetMaxY(self.v2.frame), width, height);
    }
}

//最后在dealloc中移除通知 和结束设备旋转的通知
- (void)dealloc {
    //...
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

// 决定UIViewController可以支持哪些界面方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end
