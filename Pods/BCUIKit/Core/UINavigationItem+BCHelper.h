//
//  UINavigationItem+BCHelper.h
//  Pods
//
//  Created by Basic on 2017/8/4.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationItem (BCHelper)

#pragma mark - 设置标题

/**
 设置主标题

 @param title title description
 */
- (void)bc_setTitle:(NSString *_Nullable)title;

/**
 设置子标题

 @param title title description
 */
- (void)bc_setSubTitle:(NSString *_Nullable)title;


/**
 设置标题左边距
 ! 会替换self.leftBarButtonItems
 */
- (void)bc_setupTitleLeftSpace;

#pragma mark - 设置left item


/**
 设置back item，默认是返回箭头图片

 @param action action description
 */
-(void)bc_setBackItem:(void(^_Nullable)(UIButton *sender) )action;

/**
 设置自定义left view

 @param view view description
 */
-(void)bc_setLeftItem:(UIView *_Nullable)view;
/**
 设置 left item

 @param text 文本
 @param action 点击动作
 */
-(void)bc_setLeftItemText:(NSString *_Nullable)text action:(void(^_Nullable)(UIButton *sender) )action;
/**
 设置 left item

 @param img 图片
 @param action 点击动做
 */
-(void)bc_setLeftItemImg:(UIImage *_Nullable)img action:(void(^_Nullable)(UIButton *sender) )action;

/**
 设置 left 红点 item
 
 @param img 图片
 @param action 点击动做
 */
-(void)bc_setLeftRedDotItem:(UIImage *_Nullable)img action:(void(^_Nullable)(UIButton *sender) )action;
/**
 设置left item 图片和文字

 @param img img description
 @param text text description
 @param action action description
 */
-(void)bc_setLeftItemImg:(UIImage *_Nullable)img text:(NSString *_Nullable)text action:(void(^_Nullable)(UIButton *sender) )action;

#pragma mark - 设置right item
/// rightBar 设置自定义view
/// @param view view description
-(void)bc_setRightItem:(UIView *_Nullable)view;
/// 设置right item
/// @param text 文本
/// @param action 点击事件
-(void)bc_setRightItemText:(NSString *_Nullable)text action:(void(^_Nullable)(UIButton *sender) )action;
/// 设置right item
/// @param text 文本
/// @param construction 自定义构造回调
/// @param action 点击事件
-(void)bc_setRightItemText:(NSString *_Nullable)text construction:(void(^_Nullable)(UIBarButtonItem *sender) )construction action:(void(^_Nullable)(UIButton *sender) )action;
/// 更新 right item 文案按钮
/// @param text 文本
-(void)bc_updateRightItemText:(NSString *_Nullable)text;
/// 设置right item
/// @param img 图片
/// @param action 点击动作
-(void)bc_setRightItemImg:(UIImage *_Nullable)img action:(void(^_Nullable)(UIButton *sender) )action;
/// 设置right item
/// @param img 图片
/// @param disableImg 不可用的图片
/// @param action 点击动作
-(void)bc_setRightItemImg:(UIImage *_Nullable)img withDisableImg:(UIImage *_Nullable)disableImg withAction:(void(^_Nullable)(UIButton *sender) )action;
/// 设置right item
/// @param img 图片
/// @param construction 自定义构造回调
/// @param action 点击动作
-(void)bc_addRightItemImg:(UIImage *_Nullable)img construction:(void (^_Nullable)(UIBarButtonItem * _Nonnull))construction action:(void(^_Nullable)(UIButton *sender) )action;

/**
 设置right 图片和文字
 
 @param img 图片
 @param action 点击动作
 */
-(void)bc_setRightItemImg:(UIImage *_Nullable)img text:(NSString *_Nullable)text action:(void(^_Nullable)(UIButton *sender) )action;
-(void)bc_setRightItemImg:(UIImage *_Nullable)img text:(NSString *_Nullable)text textColor:(UIColor *_Nullable)textColor action:(void(^_Nullable)(UIButton *sender) )action;
/**
 添加right item

 @param img img description
 @param action action description
 */
-(void)bc_addRightItemImg:(UIImage *_Nullable)img action:(void(^_Nullable)(UIButton *sender) )action;
@end

NS_ASSUME_NONNULL_END
