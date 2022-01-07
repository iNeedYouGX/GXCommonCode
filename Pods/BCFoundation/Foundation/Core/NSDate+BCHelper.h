//
//  NSDate+BCHelper.h
//  Pods
//
//  Created by Basic on 2017/4/4.
//
//  基础组建 - NSDate 扩展

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (BCHelper)


#pragma mark - 格式化日期
/**
 格式化日期，返回时间字符串，默认格式yyyy-MM-dd HH:mm:ss，如果是今天，显示“今天  HH:mm:ss”
 
 @return return value description
 */
- (NSString *)bc_formatFullDate;

/**
 格式化日期，返回指定格式的日期字符串
 
 @param format format description
 @return return value description
 */
- (NSString *)bc_formatDateWithFormat:(NSString *)format;

/**
 把时间字符串 按照指定格式 格式化成date，返回指定格式的日期对象

 @param dateStr 日期字符串
 @param style 格式
 @return 日期NSDate对象
 */
+ (NSDate *)bc_formatDate:(NSString *)dateStr withStyle:(NSString *)style;

/**
 把时间戳 按照指定格式 格式化成 日期字符串

 @param timeStamp 时间戳
 @param style 日期格式
 @return 日期字符串
 */
+ (NSString *)bc_formatDateStr:(NSTimeInterval)timeStamp withStyle:(NSString *)style;

/**
 把时间戳 按照指定格式 格式化成 日期字符串，默认格式yyyy-MM-dd HH:mm:ss，如果是今天，显示“今天  HH:mm:ss”

 @param timeStamp 时间戳 毫秒
 @return return value description
 */
+ (NSString *)bc_formatFullDateStr:(NSTimeInterval )timeStamp;

/// 把时间戳 按照指定格式 格式化成 日期字符串，默认格式yyyy-MM-dd style，如果是今天，显示“今天
/// @param timeStamp  时间戳 毫秒
/// @param style style 小时之后的样式
+ (NSString *)bc_formatFullDateStr:(NSInteger )timeStamp withHourStyle:(NSString *)style;

#pragma mark - helper

/**
 返回周几（周一、周二...）

 @param weekday 一个星期中的第几天
 @return 周几字符串
 */
+ (NSString *)bc_weekdayStr:(NSInteger )weekday;

/**
 时间戳（毫秒） 和 当前时间比较，NSOrderedDescending：入参时间>当前时间

 @param timeinterval timeinterval description
 @return NSOrderedDescending：入参时间>当前时间
 */
+ (NSComparisonResult )bc_compareDate:(NSTimeInterval )timeinterval;

/**
 判断是否是今天

 @return return value description
 */
- (BOOL)bc_isToday;

/**
 判断是否是明天

 @return return value description
 */
- (BOOL)bc_isTomorrow;

/**
 判断是否是昨天

 @return return value description
 */
-(BOOL)bc_isYesterday;
@end



NS_ASSUME_NONNULL_END
