//
//  UIButton+BCHelper.h
//  Pod
//
//  Created by Basic on 2016/11/17.
//  Copyright © 2016年 naruto. All rights reserved.
//

#import <UIKit/UIKit.h>

//img 和title 布局样式
/// image在上，label在下
static const int kUIButtonEdgeInsetsStyle_Top = 0;
/// image在左，label在右
static const int kUIButtonEdgeInsetsStyle_Left = 1;
/// image在下，label在上
static const int kUIButtonEdgeInsetsStyle_Bottom = 2;
/// image在右，label在左
static const int kUIButtonEdgeInsetsStyle_Right = 3;

NS_ASSUME_NONNULL_BEGIN

/// 添加点击间隔
#define BCButtonaClickInterval(sender,interval) [sender bc_addClickInterval:interval]


@interface UIButton (BCHelper)
/** image 和title 整体 top */
@property (nonatomic, assign) NSInteger   bc_contentTop;
/** image 和 title  距离 */
@property (nonatomic, assign) NSInteger   bc_contentSpace;
/** 设置点击区域 */
@property(nonatomic, assign) UIEdgeInsets bc_hitTestEdgeInsets;
/** 数字类型tag */
@property (nonatomic, assign) NSInteger bc_numTag;
/** 字符串类型tag */
@property (nonatomic, strong, nullable) NSString *bc_strTag;
/** 扩展数据 */
@property (nonatomic, strong, nullable) id    bc_extData;
/** 是否禁用圆角响应事件,默认no,可以响应 */
@property (nonatomic, assign) BOOL  bc_disableCornerEvent;

#pragma mark - system
/**
 初始化 button

 @param configureBlock configureBlock description
 @param actionBlock actionBlock description
 @return return value description
 */
+ (instancetype )bc_allocButton:(void(^ _Nullable)(UIButton *btn))configureBlock action:(void(^ _Nullable)(UIButton *btn))actionBlock;

#pragma mark - 添加 TouchUpInside 事件

/**
 添加 touch 事件

 @param actionBlock actionBlock description
 */
-(void)bc_addTouchUpInsideEvent:(void(^ _Nullable)(UIButton *btn))actionBlock;

#pragma mark - 刷新 image 、title

/**
 刷新 image 、title（更新edgeInset）
 */
- (void)bc_layoutImageTile;

/**
 刷新 image 、title（更新edgeInset）

 @param style 布局样式 kUIButtonEdgeInsetsStyle_Top
 @param space img 和 title间距
 */
- (void)bc_layoutImageTile:(int )style withSpace:(CGFloat)space;

/// 添加点击间隔
/// @param interval 间隔s
- (void)bc_addClickInterval:(CGFloat)interval;

@end

NS_ASSUME_NONNULL_END
