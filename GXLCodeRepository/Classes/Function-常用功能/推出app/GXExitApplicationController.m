//
//  GXExitApplicationController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/21.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXExitApplicationController.h"

@interface GXExitApplicationController ()

@end

@implementation GXExitApplicationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)exit:(id)sender {
   UIWindow *window = [UIApplication sharedApplication].delegate.window;
     //动画
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    }completion:^(BOOL finished) {
        exit(0);
    }];
}

- (IBAction)abort:(id)sender {
    //运行一个不存在的方法,退出界面更加圆滑
    [self performSelector:@selector(notExistCall)];
    abort();
}

@end
