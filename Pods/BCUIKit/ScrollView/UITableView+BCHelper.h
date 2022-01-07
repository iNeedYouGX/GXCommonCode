//
//  UITableView+BCHelper.h
//  BCUIKit
//
//  Created by Basic. on 2019/8/16.
//  UITableView 补充

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (BCHelper)

/// 返回table可重用UITableViewCell
/// @param clsName clsName description
- (__kindof UITableViewCell *)bc_cellWithClassName:(NSString *)clsName;

/// 返回table可重用UITableViewHeaderFooterView
/// @param clsName clsName description
- (__kindof UITableViewHeaderFooterView *)bc_headerFooterWithClassName:(NSString *)clsName;

/// 滑动到顶部
/// @param animated 是否动画
- (void)bc_scrollToTopAnimated:(BOOL)animated;

/// 滑动到低部
/// @param animated 是否动画
- (void)bc_scrollToBottomAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
