//
//  NSString+BCHelper.h
//  Pods
//
//  Created by Basic on 2017/3/24.
//  基础组件
//  NSString 扩展

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BCHelper)

///MARK: - string 校验
/**
 判断是否为空

 @param str 需要判断的字符串
 @return 是否空
 */
+ (BOOL )bc_isEmptyNull:(NSString *_Nullable)str;


/**
 去空格

 @param str 需要处理的字符串
 @return NSString
 */
+ (NSString *)bc_trimString:(NSString *_Nullable)str;

/**
 生成时间戳

 @return NSString
 */
+ (NSString *)bc_timestamp;

///MARK: - md5

/**
 获取md5 串

 @return md5 值
 */
- (NSString*)bc_md5;

///MARK: - encode decode

/**
 URL编码

 @return return value description
 */
-(NSString *)bc_encode;

/**
 URL解码

 @return return value description
 */
-(NSString *)bc_decode;

///MARK: - 字符串转json

/**
 string 转json

 @param str 需要处理的字符串
 @return json obj
 */
+ (id _Nullable)bc_jsonObject:(NSString *_Nullable)str;

///MARK: - 计算高度

/**
 获取 指定字体 字符串的大小

 @param content 指定字符串
 @param font 字体
 @return CGSize
 */
+ (CGSize )bc_autoSize:(NSString *_Nullable)content font:(UIFont *_Nullable)font;

/**
 获取 指定字体 字符串的大小

 @param content 指定字符串
 @param constraint 大写约束
 @param font 字体
 @return CGSize
 */
+ (CGSize )bc_autoSize:(NSString *_Nullable)content constraint:(CGSize)constraint font:(UIFont *_Nullable)font;

/**
 获取自适应 宽度

 @param string 指定字符串
 @param font 字体
 @return 宽度
 */
+ (CGFloat)bc_autoWidth:(NSString *_Nullable)string stringFont:(UIFont *_Nullable)font;

/**
 获取自适应 高度

 @param string 指定字符串
 @param font 字体
 @param width 宽度约束
 @return 自适应高度
 */
+ (CGFloat)bc_autoHeight:(NSString *_Nullable)string stringFont:(UIFont *_Nullable)font textWidth:(CGFloat )width;

/**
 文字高度+间距 主要针对NSMutableParagraphStyle富文本编辑

 @param string 文字
 @param font 字体
 @param space 行间距
 @param width 最大宽度
 @return 高度
 */
+ (CGFloat)bc_autoHeight:(NSString *_Nullable)string stringFont:(UIFont *_Nullable)font lineSpacing:(CGFloat )space textWidth:(CGFloat )width;

/**
 通过textView计算文本高度
 
 @param string 文字
 @param font 字体
 @param width 最大宽度
 @param attr 富文本设置
 @return 高度
 */
+ (CGFloat)bc_textViewHeightWithString:(NSString *_Nullable)string stringFont:(UIFont *_Nullable)font textWidth:(CGFloat)width attributes:(NSDictionary *_Nullable)attr;
/// 使用UILabel 计算size
/// @param string string description
/// @param font font description
/// @param width width description
/// @param lineBreakMode lineBreakMode description
+ (CGSize )bc_labelSizeWithString:(NSString *)string stringFont:(UIFont *)font textWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode )lineBreakMode;

//MARK: - 关键字查找
/// 获取某个子字符串在某个总字符串中位置数组
/// @param subString 子字符串
- (NSArray *)bc_rangeString:(NSString *_Nullable)subString;
/// 根据关键字前缀、后缀，获取关键字符串位置
/// @param prefix 关键字前缀
/// @param suffix 关键字后缀
- (NSArray<NSTextCheckingResult *> *_Nullable)bc_findKeyWithPrefix:(NSString *_Nonnull)prefix withSuffix:(NSString *_Nonnull)suffix;

//MARK: - 手机号、邮箱验证
/// 验证大陆 手机号，11位 才有效
/// @param phoneNum 大陆手机号
+ (BOOL )bc_validCNMobile:(NSString *_Nullable)phoneNum;
///  验证邮箱
/// @param email 邮箱
+ (BOOL )bc_validMail:(NSString *_Nullable)email;


//MARK: - 字符长度
/// 字符长度，emoji 表情也作为一个字符
- (NSInteger )bc_length;
/// 截取固定长度字符
/// @param to 位置
-(NSString *)bc_substringToIndex:(NSUInteger)to;

//MARK: - URL 验证
/// 获取有效的URL
/// @param url url地址
+ (NSString *)bc_getValidURL:(NSString *_Nullable)url;
/// 是否是完整的URL（以XXX://开头）
/// @param url url地址
+ (BOOL )bc_integralURL:(NSString *_Nullable)url;
/// 是否包含URL（这个比较宽松，bb.cc 也可以通过）
/// @param url url地址
+ (BOOL )bc_containURL:(NSString *_Nullable)url;

///MARK: -
/**
 返回指定宽度的image url

 @param width 宽度
 @return value description
 */
- (NSString *)bc_imageUrlWithWidth:(CGFloat)width;

/**
 隐藏中间电话号码

 @param string 手机号
 @return NSString
 */
+ (NSString *)bc_hidePhoneCoreNumber:(NSString *_Nullable)string;

///MARK: - 数字
/// 除以100忽略小数点后面的0
/// @param number number description
+ (NSString *)bc_grepPointZero:(NSInteger )number;
/**
 验证是否纯数字

 @param string string description
 @return return value description
 */
+ (BOOL )bc_validNumeral:(NSString *_Nullable)string;

/**
 秒转时分秒

 @param seconds 总的秒数
 @param format 格式化符号 ’会单独显示处理
 @return return value description
 */
+ (NSString *)bc_seconds:(CGFloat )seconds withFormatted:(NSString *_Nullable)format;

///MARK: - base64
/// base64编码
- (NSString *)bc_base64EncodedString;

/// base64解码
- (NSString *)bc_base64DecodedString;

///MARK: - emoji
+ (NSString *)bc_disableEmojiWith:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
