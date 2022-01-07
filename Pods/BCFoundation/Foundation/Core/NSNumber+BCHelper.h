//
//  NSNumber+BCHelper.h
//  Pods
//
//  Created by Basic on 15/2/8.
//  Copyright (c) 2015年 Basic. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (BCHelper)

/**
 格式化number，保留最多 x 位小数

 @param digitNums 最多保留 x 位小数
 @return return value description
 */
- (NSString *)bc_formatDigit:(int)digitNums;

/**
 格式化number，保留最多 x 位小数，整数位三位一个逗号，适合金额类型的展示
 
 @param digitNums 最多保留 x 位小数
 @return return value description
 */
- (NSString *)bc_formatDecimal:(int )digitNums;

/**
 格式化float ，最多保留两位小数

 @param data data description
 @return return value description
 */
+(NSString *)bc_formatTwoDigit:(CGFloat )data;

/// 格式化成金额字符串
/// @param money 金额,元
+(NSString *)bc_formatMoneyString:(CGFloat )money;
@end

NS_ASSUME_NONNULL_END
