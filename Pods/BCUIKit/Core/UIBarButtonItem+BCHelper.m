//
//  UIBarButtonItem+BCHelper.m
//  YT_business
//
//  Created by Basic on 15/6/2.
//  Copyright (c) 2015年 Basic. All rights reserved.
//

#import "UIBarButtonItem+BCHelper.h"
#import "BCComConfigKit/BCComConfigKit.h"
#import "UIView+BCHelper.h"
#import "UIButton+BCHelper.h"
#import <BCFoundation/NSString+BCHelper.h>
#import <BCFoundation/BCFoundationUtils.h>
#import <BCFoundation/UIImage+BCHelper.h>
#import <objc/runtime.h>

@implementation UIBarButtonItem (BCHelper)

//MARK: - Button
- (UIButton *)bc_barButton
{
    return objc_getAssociatedObject(self, @selector(bc_barButton));
}
- (void)setBc_barButton:(UIButton *)bc_barButton {
    objc_setAssociatedObject(self,@selector(bc_barButton), bc_barButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//MARK: - common
- (instancetype)bc_initWithButton:(NSString *_Nullable)text image:(UIImage *_Nullable)image action:(void(^_Nullable)(UIButton *sender) )action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //根据 image text 初始化大小
    CGRect buttonFrame = CGRectZero;
    //更新 title
    if(text.length>0){
        UIFont *fontItem = [UIFont systemFontOfSize:14] ;
        button.titleLabel.font = fontItem;
        [button setTitle:text forState:UIControlStateNormal];
        buttonFrame.size = [NSString bc_autoSize:text font:fontItem];//默认是 文字的size
    }
    //更新image
    if(image){
        [button setImage:image forState:UIControlStateNormal];
    }
    //布局刷新
    if(image && text.length>0){//图片+文字
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -6, 0.0, 0.0)];
        buttonFrame.size.width += 6+35;//加上文字和图片的间距
    }
    else if(image){//只有图片
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0, 0.0, -18)];
        CGFloat fixWidth = 50;
        if (kBCIsIPad) {
            fixWidth = 50;
        } else {
            if (@available(iOS 11.0, *)) {
                fixWidth = 25;
            }
        }
        buttonFrame.size.width += image.size.width+fixWidth;//加上 图片的width
    }
    else{//只有文字
        CGFloat fixWidth = 40;
        if (@available(iOS 11.0, *)) {
            fixWidth = 10;
        }
        buttonFrame.size.width += fixWidth;
        if (buttonFrame.size.width < 50) {
            buttonFrame.size.width = 50;
        }
    }
    buttonFrame.size.height = 30;
    button.frame = buttonFrame;
    //event
    [button bc_addTouchUpInsideEvent:^(UIButton *btn) {
        if(action){
            action(btn);
        }
    }];
    [self setBc_barButton:button];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
    [self initWithCustomView:button];
#pragma clang diagnostic pop
    return self;
}
- (void )bc_updateTextColor:(UIColor *_Nullable)color highlightColor:(UIColor *_Nullable)highlightColor disableTextColor:(UIColor *_Nullable)disableColor {
    UIButton *button = self.bc_barButton;
    if(!color){
        color = BCComConfig.config.navBtnColor;
    }
    [button setTitleColor:color forState:UIControlStateNormal];
    if(!highlightColor){
        highlightColor = BCComConfig.config.navBtnColor;
    }
    [button setTitleColor:highlightColor forState:UIControlStateHighlighted];
    if(!disableColor){
        disableColor = BCComConfig.config.navBtnDisColor;
    }
    [button setTitleColor:disableColor forState:UIControlStateDisabled];
}
- (void )bc_updateImage:(UIImage *_Nullable)image highlightImage:(UIImage *_Nullable)highlightImage disableImage:(UIImage *_Nullable)disableImage {
    UIButton *button = self.bc_barButton;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button setImage:disableImage forState:UIControlStateDisabled];
}
- (void )bc_updateBgColor:(UIColor *_Nullable)bgColor highlightColor:(UIColor *_Nullable)highlightBgColor
                disableColor:(UIColor *_Nullable)disableBgColor cornerRadius:(CGFloat )cornerRadius {
    UIButton *button = self.bc_barButton;
    CGRect buttonFrame = button.frame;
    if (bgColor) {
        [button setBackgroundImage:[UIImage bc_imageWithRoundedCornerRadius:cornerRadius renderColor:bgColor renderSize:buttonFrame.size borderWidth:0 borderCorlor:nil] forState:UIControlStateNormal];
    }
    if (highlightBgColor) {
        [button setBackgroundImage:[UIImage bc_imageWithRoundedCornerRadius:cornerRadius renderColor:highlightBgColor renderSize:buttonFrame.size borderWidth:0 borderCorlor:nil] forState:UIControlStateHighlighted];
    }
    if (disableBgColor) {
        [button setBackgroundImage:[UIImage bc_imageWithRoundedCornerRadius:cornerRadius renderColor:disableBgColor renderSize:buttonFrame.size borderWidth:0 borderCorlor:nil] forState:UIControlStateDisabled];
    }
}

//MARK: - left bar item
- (instancetype )bc_initBackItem:(void(^)(UIButton *sender) )action {
    UIImage *norImage = BCComConfig.config.navBackImg;
    return [self bc_initLeftItem:norImage highlightImage:nil text:nil textColor:nil action:action];
}

- (instancetype)bc_initLeftItem:(UIImage *)image highlightImage:(UIImage *)highImage text:(NSString *)text textColor:(UIColor *)textColor action:(void(^)(UIButton *sender) )action {
    return [self bc_initLeftItem:image withHighlightImage:highImage withText:text withTextColor:textColor withRedDot:false withAction:action];
}
- (instancetype)bc_initLeftItem:(UIImage *)image withHighlightImage:(UIImage *)highImage withText:(NSString *)text withTextColor:(UIColor *)textColor withRedDot:(BOOL)showRedDot withAction:(void(^)(UIButton *sender) )action {
    //添加按钮
    UIFont *fontItem = BCComConfig.config.bcFont(14);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    CGRect buttonFrame = CGRectZero;
    if(text.length>0){
        if(!textColor){
            textColor = BCComConfig.config.navBtnColor;
        }
        [button setTitleColor:textColor forState:UIControlStateNormal];
        [button setTitleColor:BCComConfig.config.navBtnDisColor forState:UIControlStateDisabled];
        button.titleLabel.font = fontItem;
        [button setTitle:text forState:UIControlStateNormal];
        buttonFrame.size = [NSString bc_autoSize:text font:fontItem];//默认是 文字的size
    }
    if(image){
        [button setImage:image forState:UIControlStateNormal];
        if (highImage) {
            [button setImage:highImage forState:UIControlStateHighlighted];
        }
    }
    if(image && text.length>0){//图片+文字
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -6, 0.0, 0.0)];
        buttonFrame.size.width += 6+35;//加上文字和图片的间距
    }
    else if(image){//只有图片
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
        CGFloat fixWidth = 50;
        if (kBCIsIPad) {
            fixWidth = 50;
        } else {
            if (@available(iOS 11.0, *)) {
                fixWidth = 25;
            }
        }
        buttonFrame.size.width += image.size.width+fixWidth;//加上 图片的width
    }
    else{//只有文字
        CGFloat fixWidth = 40;
        if (@available(iOS 11.0, *)) {
            fixWidth = 10;
        }
        buttonFrame.size.width += fixWidth;
    }
    buttonFrame.size.height = 38;
    button.frame = buttonFrame;
    [button bc_addTouchUpInsideEvent:^(UIButton *btn) {
        if(action){
            action(btn);
        }
    }];
    //添加红点
    if (showRedDot && image) {
        UIImageView *redDotImgv = [[UIImageView alloc] initWithFrame:CGRectMake(buttonFrame.size.width/2.0+image.size.width/2.0-8, buttonFrame.size.height/2.0-image.size.height/2.0-3, 6, 6)];
        redDotImgv.layer.cornerRadius = 3;
        redDotImgv.layer.masksToBounds = true;
        redDotImgv.backgroundColor = BCComConfigColorValue(@"redColor", UIColor.redColor);
        [button addSubview:redDotImgv];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
    [self initWithCustomView:button];
#pragma clang diagnostic pop
    [self setBc_barButton:button];
    return self;
}

//MARK: - enabled
-(void)bc_setEnabled:(BOOL)enabled {
    self.enabled = enabled;
    if([self.customView isKindOfClass:[UIButton class]]){
        UIButton *btnBarItem = (UIButton *)self.customView;
        btnBarItem.enabled = enabled;
    }
}
@end
