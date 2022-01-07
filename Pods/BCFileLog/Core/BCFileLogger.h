//
//  BCFileLogger.h
//  Pod
//
//  Created by Basic on 2017/3/13.
//  Copyright © 2017年 naruto. All rights reserved.
//  基础组件 - 日志文件组件
//  日志文件实现

#import <Foundation/Foundation.h>

#define kBCFileLoggerIntance                    [BCFileLogger shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface BCFileLogger : NSObject
#pragma mark - system

/**
 获取文件日志 单例

 @return BCFileLogger
 */
+ (instancetype) shareInstance;

#pragma mark - public

/**
 根据时间选择日志文件

 @param logDate 时间字符串2017-03-09
 @return 返回匹配的日志文件路径
 */
- (NSString *)bc_getLogFilePath:(NSString *)logDate;


#pragma mark - 读写日志
/**
 添加日志
 
 @param strLog 内容
 */
- (void)addLog:(NSString *_Nullable)strLog withTime:(BOOL )addTime;
/**
 输出日志，包含当前时间信息
 
 @param level 日志级别[暂不用]
 @param label 日志标签[暂不用]
 @param format format 格式化
 @param ... 可变参数
 */
void BCFileLoggerWrite(int level, NSString *_Nullable label, NSString *_Nullable format, ...);

@end


NS_ASSUME_NONNULL_END
