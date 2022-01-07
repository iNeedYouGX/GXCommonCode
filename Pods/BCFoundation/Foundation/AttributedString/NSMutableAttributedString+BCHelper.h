//
//  NSMutableAttributedString+BCHelper.h
//  Pods
//
//  Created by Basic on 2017/7/16.
//  基础组件
//  NSMutableAttributedString 扩展

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (BCHelper)

//MARK: - 更改颜色、字体
- (void )bc_changeColor:(UIColor *)color SubStringArray:(NSArray *)subArray;
- (void )bc_changeFont:(UIFont *)font SubStringArray:(NSArray *)subArray;
- (void )bc_changeFontColor:(UIFont *_Nullable)font Color:(UIColor *_Nullable)color SubStringArray:(NSArray *)subArray;
- (void )bc_changeColor:(UIColor *)color range:(NSRange )range;
- (void )bc_changeFontColor:(UIFont *_Nullable)font Color:(UIColor *_Nullable)color range:(NSRange )range;
/**
 修改某个字符换的颜色、字体，并自定义其他属性
 
 @param font 修改后的字体
 @param color 修改后的颜色
 @param keyword 查找的关键字
 @param otherAttr 自定义其他属性的block
 */
- (void )bc_changeFont:(UIFont *_Nullable)font withColor:(UIColor *_Nullable)color withKeyword:(NSString *_Nullable)keyword withOtherAttr:(void(^_Nullable)(NSMutableAttributedString *attr, NSRange range) )otherAttr;

//MARK: - 追加文字
/// 根据颜色、字体追加AttributeString
/// @param keyword 文字
/// @param font 字体
/// @param color 颜色
- (void )bc_appendAttribute:(NSString *_Nullable)keyword withFont:(UIFont *_Nullable)font withColor:(UIColor *_Nullable)color;
/// 根据颜色、字体、自定义属性，追加AttributeString
/// @param keyword 文字
/// @param font 字体
/// @param color 颜色
/// @param otherAttr 自定义其他属性的block
- (void )bc_appendAttribute:(NSString *_Nullable)keyword withFont:(UIFont *_Nullable)font withColor:(UIColor *_Nullable)color withOtherAttr:(void(^_Nullable)(NSMutableAttributedString *_Nonnull attr) )otherAttr;

//MARK: - 计算size
/**
 计算size

 @param maxSize 最大size
 @param lineSpace 行间隔
 @return return value description
 */
- (CGSize )bc_autoSize:(CGSize)maxSize withLineSpace:(CGFloat )lineSpace;
/**
 自适应高度

 @param maxWidth 最大宽度
 @param lineSpace 行间距
 @return return value description
 */
- (CGFloat )bc_autoHeight:(CGFloat)maxWidth withLineSpace:(CGFloat )lineSpace;
@end

NS_ASSUME_NONNULL_END
