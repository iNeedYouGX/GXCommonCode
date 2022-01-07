//
//  BCFileLog.h
//  Pod
//
//  Created by Basic on 2017/3/13.
//  Copyright © 2017年 naruto. All rights reserved.
//  基础组件 - 日志文件组件
//  头文件

#ifndef BCFileLog_h
#define BCFileLog_h

#import "BCFileLogger.h"


#pragma mark - info 日志[输出并且记录文件]
//info等级日志：输出日志（内容=参数）
#define BCLogInfo(fmt,...)                          BCFileLoggerWrite(3,nil,fmt,__VA_ARGS__)
#define BCLogInfoStr(str)                           BCLogInfo(@"%@",str)
#define BCLogInfoNull()                             BCLogInfoStr(nil)

//info等级日志：输出日志（内容=函数名+行号+参数）
#define BCLogInfos(fmt,...)                         BCFileLoggerWrite(3,nil,(@"%s:%d|" fmt), __FUNCTION__, __LINE__,__VA_ARGS__)
#define BCLogInfosStr(str)                          BCLogInfos(@"%@",str)
#define BCLogInfosNull()                            BCLogInfosStr(nil)


#pragma mark - file 日志[不输出只记录文件]
//info等级日志：输出日志（内容=参数）
#define BCLogFile(fmt,...)                          BCFileLoggerWrite(0,nil,fmt,__VA_ARGS__)
#define BCLogFileStr(str)                           BCLogFile(@"%@",str?str:@"")
#define BCLogFileNull()                             BCLogFileStr(nil)

//info等级日志：输出日志（内容=函数名+行号+参数）
#define BCLogFiles(fmt,...)                         BCFileLoggerWrite(0,nil,(@"%s:%d|" fmt), __FUNCTION__, __LINE__,__VA_ARGS__)
#define BCLogFilesStr(str)                          BCLogFiles(@"%@",str?str:@"")
#define BCLogFilesNull()                            BCLogFilesNull(nil)

#endif /* BCFileLog_h */
