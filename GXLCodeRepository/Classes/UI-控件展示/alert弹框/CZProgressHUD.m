//
//  CZProgressHUD.m
//  BestCity
//
//  Created by JasonBourne on 2018/8/9.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "CZProgressHUD.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

@interface CZProgressHUD ()
/** 整个view */
@property (nonatomic, strong) CZProgressHUD *hud;
/** 显示的文字 */
@property (nonatomic, strong) UIButton *textLabel;
@end

@implementation CZProgressHUD

static id _instance;

+ (instancetype)shareProgress
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return _instance;
}

- (UIButton *)textLabel
{
    if (_textLabel == nil) {
        UIButton *label = [[UIButton alloc] init];
        [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        label.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        label.titleLabel.numberOfLines = 0;
        label.titleLabel.font = [UIFont systemFontOfSize:13];
        label.layer.cornerRadius = 13;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor colorWithRed:21/255.0 green:21/255.0 blue:21/255.0 alpha:0.87];
        _textLabel = label;
    }
    return _textLabel;
}

+ (instancetype)showProgressHUDWithText:(NSString *)text
{
    if (text == nil) {
        [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD show];
        return nil;
    } else {
        CZProgressHUD *hud = [self shareProgress];
        
        hud.backgroundColor = [UIColor clearColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview: hud];
        
        [hud addSubview:hud.textLabel];
        
        [hud.textLabel setTitle:[NSString stringWithFormat:@"%@", text] forState:UIControlStateNormal];
        
        CGFloat height = [hud.textLabel.titleLabel.text getTextHeightWithRectSize:CGSizeMake(SCR_WIDTH - 40 - 20, 1000) andFont:[UIFont systemFontOfSize:13]] + 20;
        
        [hud.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(20));
            make.right.equalTo(@(-20));
            make.center.equalTo(hud);
            make.height.equalTo(@(height));
        }];
        
        return hud;
    }
}

+ (instancetype)showOrangeProgressHUDWithText:(NSString *)text
{
    CZProgressHUD *hud = [self shareProgress];
    hud.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview: hud];

    [hud addSubview:hud.textLabel];
    [hud.textLabel setTitle:[NSString stringWithFormat:@"　%@　", text] forState:UIControlStateNormal];
    hud.textLabel.backgroundColor = UIColorFromRGB(0xE25838);
    [hud.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (IsiPhoneX) {
            make.top.mas_offset(@142);
        } else {
            make.top.mas_offset(@120);
        }
        make.centerX.equalTo(hud);
        make.height.equalTo(@(26));
    }];
    return hud;
}


#pragma mark -- 删除
+ (void)hideAfterDelay:(NSTimeInterval)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [[self shareProgress] removeFromSuperview];
    });
}


@end
