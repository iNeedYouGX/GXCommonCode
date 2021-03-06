//
//  CZProgressHUD.h
//  BestCity
//
//  Created by JasonBourne on 2018/8/9.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
@interface CZProgressHUD : UIView

+ (instancetype)showProgressHUDWithText:(NSString *)text;
+ (instancetype)showOrangeProgressHUDWithText:(NSString *)text;
+ (void)hideAfterDelay:(NSTimeInterval)delay;

@end
