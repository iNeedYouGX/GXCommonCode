//
//  BCEventBusHelper.h
//  BCEventBus
//
//  Created by Basic on 2019/9/26.
//  事件中心 - helper

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCEventBusHelper : NSObject


#pragma mark - helper

/**
 根据字符串 获取 事件名称（这里只是加上一个前缀）
 
 @param name name description
 @return return value description
 */
+ (NSString *) getEventNameWithStr:(NSString *)name;
/**
 根据class 获取 事件名称（这里只是加上一个前缀）
 
 @param eventClass eventClass description
 @return return value description
 */
+ (NSString *) getEventNameWithClass:(Class )eventClass;
/**
 根据class 名称 获取 事件名称（这里只是加上一个前缀）

 @param clsName clsName description
 @return return value description
 */
+ (NSString *) getEventNameWithClassName:(NSString *)clsName;
/**
 根据protocol 对象获取事件名称（这里只是加上一个前缀）
 
 @param protocol 协议对象
 @return return value description
 */
+ (NSString *) getEventNameWithProtocol:(Protocol *)protocol;
/**
 根据protocol name获取事件名称（这里只是加上一个前缀）
 
 @param protocolName 协议名称
 @return return value description
 */
+ (NSString *) getEventNameWithProtocolName:(NSString *)protocolName;

@end

NS_ASSUME_NONNULL_END
