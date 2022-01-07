//
//  UINavigationBar+BCHelper.h
//  Pod
//
//  Created by Basic on 15/6/2.
//  Copyright (c) 2015年 Basic. All rights reserved.
//  导航栏两种实现，使用 hh_useSystem 属性来选择实现
//  1.自定义方式，添加一个view
//  2:使用系统的，用setImage:forBarMetrics修改颜色

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (BCHelper)
/** 是否使用系统实现，默认NO，内部会添加一个view，用来改透明色，加分割线 */
@property (class, nonatomic, assign) BOOL hh_useSystem;

#pragma mark - 设置背景色
/**
 设置 bar 背景色

 @param backgroundColor backgroundColor description
 */
- (void)bc_setBackgroundColor:(UIColor *_Nullable)backgroundColor;

#pragma mark - 自定义分割线
- (UIColor *)bc_splitColor;
/**
 设置 分割线颜色

 @param splitColor splitColor description
 */
- (void)bc_setSplitColor:(UIColor *_Nullable)splitColor;
/**
 设置分割线透明度

 @param alpha alpha description
 */
- (void)bc_setSplitAlpha:(CGFloat )alpha;

#pragma mark - 渐变背景

/**
 显示渐变背景

 @param startColor 开始颜色
 @param startPoint 开始位置
 @param endColor 结束颜色
 @param endPoint 结束位置
 */
- (void)bc_showGradientLayer:(UIColor *)startColor withStartPoint:(CGPoint )startPoint withEndColor:(UIColor *)endColor withEndPoint:(CGPoint )endPoint;

#pragma mark - Helper
/**
 检测navigationBar 是否显示了，ios 12 UITabBar+UINavigationController，自定义的navigationView，在willAppear的时候，[self.subviews firstObject] 是空的，导致没有被成功insert
 */
- (void) bc_checkNavBarHasShow;
@end


NS_ASSUME_NONNULL_END
