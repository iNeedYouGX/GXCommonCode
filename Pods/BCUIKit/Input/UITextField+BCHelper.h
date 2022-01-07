//
//  UITextField+BCHelper.h
//  Pods
//
//  Created by Basic on 2017/8/14.
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (BCHelper)
/// placeholder 颜色
@property (strong, nonatomic) UIColor   *bc_placeholderColor;
/// placeholder 字体
@property (strong, nonatomic) UIFont    *bc_placeholderFont;
/// 最大长度，自动截取
@property (assign, nonatomic) NSInteger bc_maxLength;
/// 是否禁止emoji 需设置bc_maxLength组合生效
@property (assign, nonatomic) BOOL bc_disableEmoji;

#pragma mark - 更新 Placeholder

/**
 更新 Placeholder 显示
 */
- (void)bc_updatePlaceholder;


#pragma mark - 最大字符数限制
/**
 验证最大字符数，自动截取
 返回 YES，表示未超过最大字符数；返回 NO，表示超过最大字符数，并自动截取

 @param maxLength 最大字符数目，emoji 表情作为一个字符处理
 */
- (BOOL)bc_validMaxLength:(NSUInteger )maxLength;

NS_ASSUME_NONNULL_END

@end
