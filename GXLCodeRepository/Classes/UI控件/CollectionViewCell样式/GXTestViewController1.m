//
//  GXTestViewController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/12/30.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXTestViewController1.h"

@interface GXTestViewController1 ()

@end

@implementation GXTestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [RANDOMCOLOR colorWithAlphaComponent:.4];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     NSLog(@"当前是%@: presentingVC = %@", NSStringFromClass([self class]), self.presentingViewController);
    [self dismissViewControllerAnimated:YES completion:^{

    }];

}

//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    GXTestViewController1 *vc = [[GXTestViewController1 alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self presentViewController:vc animated:YES completion:^{
//        NSLog(@"当前是kindsofVC: presentedVC = %@", self.presentedViewController);
//    }];
//}

@end
