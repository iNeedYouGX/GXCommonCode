//
//  UIBarButtonItem+BCHelper.h
//  Pod
//
//  Created by Basic on 15/6/2.
//  Copyright (c) 2015年 Basic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (BCHelper)
/// 内部button
@property (nonatomic, strong, nullable) UIButton *bc_barButton;

//MARK: - common
/// 初始化 button barItem
/// @param text 文本
/// @param image 图片
/// @param action 点击事件
- (instancetype)bc_initWithButton:(NSString *_Nullable)text image:(UIImage *_Nullable)image action:(void(^_Nullable)(UIButton *sender) )action;
/// 更新 text
/// @param color 文本色
/// @param highlightColor 高亮文本色
/// @param disableColor 不可用文本色
- (void )bc_updateTextColor:(UIColor *_Nullable)color highlightColor:(UIColor *_Nullable)highlightColor disableTextColor:(UIColor *_Nullable)disableColor;
/// 更新 image
/// @param image 图片
/// @param highlightImage 高亮图片
/// @param disableImage 不可用图片
- (void )bc_updateImage:(UIImage *_Nullable)image highlightImage:(UIImage *_Nullable)highlightImage disableImage:(UIImage *_Nullable)disableImage;
/// 更新 UIBarButtonItem 背景色
/// @param bgColor 背景色
/// @param highlightBgColor 高亮背景色
/// @param disableBgColor 不可用景色
/// @param cornerRadius 圆角
- (void )bc_updateBgColor:(UIColor *_Nullable)bgColor highlightColor:(UIColor *_Nullable)highlightBgColor
             disableColor:(UIColor *_Nullable)disableBgColor cornerRadius:(CGFloat )cornerRadius;



//MARK: - left bar item
/**
 初始化 返回 barItem

 @param action action description
 @return return value description
 */
- (instancetype)bc_initBackItem:(void(^_Nullable)(UIButton *sender) )action;
/**
 初始化 left barItem

 @param image 正常图片
 @param highImage 高亮图片
 @param text text 文字
 @param textColor 文字颜色
 @param action 点击事件
 @return return value description
 */
- (instancetype)bc_initLeftItem:(UIImage *_Nullable)image highlightImage:(UIImage *_Nullable)highImage text:(NSString *_Nullable)text textColor:(UIColor *_Nullable)textColor action:(void(^_Nullable)(UIButton *sender) )action;
/**
 初始化 left barItem，可设置 红点

 @param image 正常图片
 @param highImage 高亮图片
 @param text text 文字
 @param textColor 文字颜色
 @param showRedDot 是否显示红点
 @param action 点击事件
 @return return value description
 */
- (instancetype)bc_initLeftItem:(UIImage *_Nullable)image withHighlightImage:(UIImage *_Nullable)highImage withText:(NSString *_Nullable)text withTextColor:(UIColor *_Nullable)textColor withRedDot:(BOOL)showRedDot withAction:(void(^_Nullable)(UIButton *sender) )action;

#pragma mark - enabled

/**
 设置enable，会设置customView的enabled

 @param enabled 是否可用
 */
-(void)bc_setEnabled:(BOOL)enabled;

@end


NS_ASSUME_NONNULL_END
