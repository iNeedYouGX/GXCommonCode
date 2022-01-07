//
//  UITabBar+HHRedBadge.h
//  BCUIKit
//
//  Created by chun.chen on 2021/8/30.
//  tabbar 红色角标

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (HHRedBadge)

/// 显示小红点
/// @param index 将要显示小红点的tabbarItem的索引(第一个item的索引为0)
- (void)hh_showDotAtIndex:(NSInteger)index;

/// 隐藏小红点
/// @param index index 将要隐藏小红点的tabbarItem的索引(第一个item的索引为0)
- (void)hh_hiddenDotAtIndex:(NSInteger)index;

@end


@interface UITabBarItem (HHRedBadge)

/// 添加小红点
- (void)hh_addRedBadge;

/// 移除小红点
- (void)hh_removeRedBadge;
@end

NS_ASSUME_NONNULL_END
