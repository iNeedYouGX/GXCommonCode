//
//  UITabBar+HHRedBadge.m
//  BCUIKit
//
//  Created by chun.chen on 2021/8/30.
//

#import "UITabBar+HHRedBadge.h"

@implementation UITabBar (HHRedBadge)

- (void)hh_showDotAtIndex:(NSInteger)index
{
    if (index >= self.items.count) {
        return;
    }
    UITabBarItem *item = self.items[index];
    [item hh_addRedBadge];
}

- (void)hh_hiddenDotAtIndex:(NSInteger)index
{
    if (index >= self.items.count) {
        return;
    }
    UITabBarItem *item = self.items[index];
    [item hh_removeRedBadge];
}

@end

///MARK: - UITabBarItem
@implementation UITabBarItem (HHRedBadge)

- (void)hh_addRedBadge {
    // 获取 UITabBarItem 中的 view: UITabBarButton
    UIView *tabBarButton = [self valueForKey:@"view"];
    // 通过设置 badgeValue 的值让系统添加大胖点
    self.badgeValue = @"";
    // 大胖点的颜色设置为透明 iOS 10 才能使用
    if (@available(iOS 10.0, *)) {
        self.badgeColor = [UIColor clearColor];
    } else {
        // Fallback on earlier versions
    }

    // 遍历 UITabBarItem view 的 subviews
    for (UIView *subview in tabBarButton.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"_UIBadgeView"]) {
            // 此时的 subview 是 _UIBadgeView
            UIView *badgeView = subview;

            for (UIView *badgeSubview in badgeView.subviews) {
                // 如果已有小红点, 则先移除
                if (badgeSubview.tag == 999) {
                    [badgeSubview removeFromSuperview];
                }

                // iOS 9 才通过此方式设置大胖点的颜色
                if ([UIDevice currentDevice].systemVersion.doubleValue < 10) {
                    // 设置 _UIBadgeBackgound 的背景色为透明
                    NSString *aViewClassStr = NSStringFromClass([badgeSubview class]);
                    if ([aViewClassStr isEqualToString:@"_UIBadgeBackground"]) {
                        // 将 badgeSubview 的 image 属性设置为 nil, 大胖点就消失了, 所以推测原生的大胖点就是一个 18*18 的图片
                        [badgeSubview setValue:nil forKey:@"image"];
                    }
                }
            }

            // 创建一个小红点, BADGE_DIAMETER 为红点直径
            UIView *customBadge = [[UIView alloc] initWithFrame:CGRectMake(-2, 4, 10, 10)];
            // 设置小红点的颜色
            customBadge.backgroundColor = [UIColor redColor];

            // 小红点切圆角
            customBadge.layer.cornerRadius = customBadge.frame.size.height / 2;
            customBadge.layer.masksToBounds = YES;
            customBadge.layer.borderColor = [[UIColor whiteColor] CGColor];
            customBadge.layer.borderWidth = 1.5f;
            // 设置 tag
            customBadge.tag = 999;

            // 将小红点添加到大胖点上
            [badgeView addSubview:customBadge];
        }
    }
}

- (void)hh_removeRedBadge {
    UIView *tabBarButton = [self valueForKey:@"view"];
    // 遍历 UITabBarItem view 的 subviews
    for (UIView *subview in tabBarButton.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"_UIBadgeView"]) {
            // 此时的 subview 是 _UIBadgeView
            UIView *badgeView = subview;
            for (UIView *badgeSubview in badgeView.subviews) {
                if (badgeSubview.tag == 999) {
                    [badgeSubview removeFromSuperview];
                    return;
                }
            }
        }
    }
}

@end
