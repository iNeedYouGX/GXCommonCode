//
//  NSAttributedString+BCHelper.h
//  Pods
//
//  Created by Basic on 2017/4/1.
//  基础组件
//  NSAttributedString 扩展

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (BCHelper)

//MARK: - 更改颜色、字体

/**
 类方法生成 NSAttributedString

 @param color 字体颜色
 @param totalString 文本
 @return NSAttributedString
 */
+ (instancetype )bc_initColor:(UIColor *)color TotalString:(NSString *_Nullable)totalString;

/**
 类方法生成 NSAttributedString
 
 @param font 字体
 @param totalString 文本
 @return NSAttributedString
 */
+ (instancetype )bc_initFont:(UIFont *)font TotalString:(NSString *_Nullable)totalString;


/**
 类方法生成 NSAttributedString

 @param font 字体
 @param color 字体颜色
 @param totalString 文本
 @return NSAttributedString
 */
+ (instancetype )bc_initFont:(UIFont *_Nullable)font Color:(UIColor *_Nullable)color TotalString:(NSString *_Nullable)totalString;

/**
 类方法生成 NSAttributedString

 @param color 改变的字体颜色
 @param totalString 全文本
 @param subArray 需要改变的文本
 @return NSAttributedString
 */
+ (instancetype )bc_changeColor:(UIColor *)color TotalString:(NSString *_Nullable)totalString SubStringArray:(NSArray *)subArray;

/**
  类方法生成 NSAttributedString

 @param totalString 文本
 @param space 行间距
 @return NSAttributedString
 */
+ (instancetype) bc_initString:(NSString *_Nullable)totalString withSpace:(CGFloat)space;

/**
 类方法生成 NSAttributedString

 @param totalString 文本
 @param space 行间距
 @param font 字体
 @return NSAttributedString
 */
+ (instancetype) bc_initString:(NSString *_Nullable)totalString withSpace:(CGFloat)space font:(UIFont *_Nullable)font;

/**
 类方法生成 NSAttributedString

 @param text 文本
 @param image 图片
 @param left 图片在左或在右边
 @return NSAttributedString
 */
+ (instancetype)bc_initText:(NSString *_Nullable)text image:(UIImage *)image onLeft:(BOOL)left;



#pragma mark - 修改行间距
/**
 单纯改变句子的字间距

 @param totalString 需要更改的字符串
 @param space 字间距
 @return 生成的富文本
 */
+ (NSAttributedString *)bc_changeSpaceWithTotalString:(NSString *_Nullable)totalString Space:(CGFloat)space;

+ (NSAttributedString *)bc_changeLineSpaceWithTotalString:(NSString *_Nullable)totalString LineSpace:(CGFloat)lineSpace;

+ (NSAttributedString *)bc_changeLineSpaceWithTotalString:(NSString *_Nullable)totalString LineSpace:(CGFloat)lineSpace font:(UIFont *)font;

+ (NSAttributedString *)bc_changeLineAndTextSpaceWithTotalString:(NSString *_Nullable)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;


//MARK: - 计算高度
/**
 自适应高度

 @param maxWidth 最大宽度
 @return return value description
 */
- (CGFloat )bc_autoHeight:(CGFloat)maxWidth;
@end

NS_ASSUME_NONNULL_END
