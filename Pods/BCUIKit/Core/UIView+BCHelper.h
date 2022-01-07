//
//  UIView+BCHelper.h
//  Pod
//
//  Created by Basic on 2016/11/16.
//  Copyright © 2016年 naruto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 检测点击间隔
#define BCViewCheckRepeatClick(sender,interval) \
do { \
NSTimeInterval kBCClickTime = [[NSDate date] timeIntervalSince1970];\
if(sender && sender.bc_lastClickDate>0)\
{\
NSTimeInterval kBCDiffTime = kBCClickTime - sender.bc_lastClickDate;\
if(ABS(kBCDiffTime)<=interval)\
{\
sender.bc_lastClickDate = kBCClickTime;\
return ;\
}\
}\
sender.bc_lastClickDate = kBCClickTime;\
}\
while (0);

/// 渐变色方向，从上到下
static const NSInteger BCGradientDirectionTopBottom = 0;
/// 渐变色方向，从左到右
static const NSInteger BCGradientDirectionLeftRight = 1;
/// 渐变色方向，从左上角到右下角
static const NSInteger BCGradientDirectionTopLeftBottomRight = 2;

@interface UIView (BCHelper)
///上次点击时间
@property (nonatomic, assign) NSTimeInterval    bc_lastClickDate;
///渐变背景色 layer
@property (strong, nonatomic, nullable) CAGradientLayer   *bc_gradientBgLayer;

//MARK: - frame
// coordinator getters
- (CGFloat)bc_height;
- (CGFloat)bc_width;
- (CGFloat)bc_x;
- (CGFloat)bc_y;
- (CGSize)bc_size;

//origin
- (CGPoint )bc_origin;
- (void)setBc_origin:(CGPoint )origin;

//bottom
- (CGFloat)bc_bottom;
- (void )setBc_bottom:(CGFloat)bottom;
- (CGFloat)bc_right;
- (void )setBc_right:(CGFloat)right;

- (void)setBc_x:(CGFloat)x;
- (void)setBc_y:(CGFloat)y;

// height
- (void)setBc_height:(CGFloat)height;
- (void)bc_heightEqualToView:(UIView *)view;

// width
- (void)setBc_width:(CGFloat)width;
- (void)bc_widthEqualToView:(UIView *)view;

// center
- (CGFloat)bc_centerX;
- (void)setBc_centerX:(CGFloat)centerX;
- (CGFloat)bc_centerY;
- (void)setBc_centerY:(CGFloat)centerY;

// size
- (void)setBc_size:(CGSize)size;
- (void)bc_sizeEqualToView:(UIView *)view;

//MARK: - Constraint

/// 获取约束的值
/// @param attribute 约束属性类型，NSLayoutAttribute
- (CGFloat )getConstraintValue:(NSLayoutAttribute )attribute;

//MARK: - 圆角边框
/// 添加边框
/// @param top top description
/// @param bottom bottom description
/// @param left left description
/// @param right right description
/// @param color color description
- (void)bc_addBorderTop:(BOOL)top bottom:(BOOL)bottom left:(BOOL)left right:(BOOL)right color:(UIColor *)color;
///添加圆角
- (void)bc_addCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

//MARK: - 单击、长按手势
/// 添加 单击手势
/// @param block 单击事件handle
- (void)bc_addTapActionWithBlock:(void (^_Nullable)(UIGestureRecognizer *gestureRecoginzer) )block;
/// 移除单击手势
- (void)bc_removeTapGesture;
/// 添加长按手势
/// @param block 长按事件handle
- (void)bc_addLongPressActionWithBlock:(void (^_Nullable)(UIGestureRecognizer *gestureRecoginzer) )block;
/// 添加长按手势
/// @param block 长按事件handle
- (void)bc_addLongPressGesture:(NSInteger )minDuration withBlock:(void (^_Nullable)(UIGestureRecognizer *gestureRecoginzer) )block;
/// 移除长按手势
- (void)bc_removeLongPressGesture;

//MARK: - utils
/// 查找第一响应者
- (UIView *)bc_firstResponder;
/// 查找对应的VC
/// @param clsName vc 类名
- (UIViewController *)bc_viewControllerWithName:(nullable NSString *)clsName;
/// 根据tag 查找子 view
/// @param tag 需要查找的tag
- (UIView *)bc_subviewWithTag:(NSInteger)tag;

//MARK: - 渐变色
/// 设置渐变背景色，默认根据view的大小。
/// @param direction 样式，eg：BCGradientDirectionTopBottom
/// @param startColor 左边的颜色
/// @param endColor 右边的颜色
- (void)bc_setGradientBgColor:(NSInteger )direction startColor:(UIColor *)startColor endColor:(UIColor *)endColor;
/// 设置渐变背景色，可设置大小。
/// @param direction 样式，eg：BCGradientDirectionTopBottom
/// @param startColor 左边的颜色
/// @param endColor 右边的颜色
/// @param frame 渐变色大小
- (void)bc_setGradientBgColor:(NSInteger )direction startColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect )frame;

@end


NS_ASSUME_NONNULL_END
