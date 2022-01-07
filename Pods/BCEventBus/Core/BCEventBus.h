//
//  BCEventBus.h
//  BCRoBCEventBusuteKit
//
//  Created by Basic on 2018/11/13.
//  事件中心

#import <Foundation/Foundation.h>
#import "BCEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCEventBus<Value> : NSObject
/** 事件中心 单例 */
@property (class, readonly) BCEventBus *shareBus;

//MARK: - class 事件

/**
 订阅具体class事件
 
 @param eventCls 事件class
 @param target 需要订阅的target，如果target销毁，则监听的所有事件也销毁了
 @return return value description
 */
-(BCEvent *)subscribeClass:(Class )eventCls withTarget:(id )target;
/**
 订阅具体class事件

 @param eventCls 事件class
 @param identifier 唯一标识符，内部 class+identifier 作为事件标识符
 @param target 需要订阅的target，如果target销毁，则监听的所有事件也销毁了
 @return return value description
 */
-(BCEvent *)subscribeClass:(Class )eventCls withIdentifier:(NSString * _Nullable)identifier withTarget:(id )target;
/**
 发布具体的事件
 
 @param event 事件模型，可以实现 BCEventProtocol 协议，也可以不实现。
 */
- (void)publish:(id )event;
/**
 发布具体的事件
 
 @param eventCls 事件class name
 @param event 事件对象
 */
- (void)publishClass:(Class _Nullable)eventCls withEvent:(id _Nullable)event;
/**
 发布具体的事件
 
 @param eventCls 事件class name
 @param identifier 唯一标识符，内部 class+identifier 作为事件标识符
 @param event 事件对象
 */
- (void)publishClass:(Class _Nullable)eventCls withIdentifier:(NSString * _Nullable)identifier withEvent:(id _Nullable)event;

//MARK: - 字符串事件
/**
 订阅某个名字的事件

 @param eventName 事件名称
 @param target 需要订阅的target，如果target销毁，则监听的所有事件也销毁了
 @return return value description
 */
-(BCEvent *)subscribeName:(NSString *)eventName withTarget:(id)target;
/**
 发布某个名字的事件，并可以附带一些简单的数据
 
 @param eventName 事件名称
 @param data 附带的数据，一般是简单的数据
 */
- (void)publishName:(NSString *)eventName withData:(id _Nullable)data;


//MARK: - protocol 事件
typedef void (^BCEventProtocolBlock)(Value target);
/**
 根据协议对象，target 订阅某个协议的事件
 
 @param protocol 需要订阅的协议
 @param target 需要订阅的target，如果target销毁，则监听的所有事件也销毁了
 */
-(void )subscribeProtocol:(Protocol * _Nullable)protocol withTarget:(id)target;
-(void )subscribeProtocol:(Protocol * _Nullable)protocol withIdentifier:(NSString * _Nullable)identifier withTarget:(id)target;
/**
 根据协议名字，target 订阅某个协议的事件
 
 @param protocolName 协议名字
 @param target 需要订阅的target，如果target销毁，则监听的所有事件也销毁了
 */
-(void )subscribeProtocolName:(NSString * _Nullable)protocolName withTarget:(id)target;
-(void )subscribeProtocolName:(NSString * _Nullable)protocolName withIdentifier:(NSString * _Nullable)identifier withTarget:(id)target;
/**
 根据协议对象，发布某个协议的事件

 @param protocol protocol description
 @param handle 具体需要执行协议的某个方法，发布者必须要知道发布协议的某个方法
 */
- (void)publishProtocol:(Protocol *)protocol withHandle:(void(^_Nullable)(Value target))handle;
- (void)publishProtocol:(Protocol *)protocol withIdentifier:(NSString * _Nullable)identifier withHandle:(void(^_Nullable)(Value target))handle;
/**
 根据协议名字，发布某个协议的事件

 @param protocolName 协议名称
 @param handle 具体需要执行协议的某个方法，发布者必须要知道发布协议的某个方法
 */
- (void)publishProtocolName:(NSString *)protocolName withHandle:(void(^_Nullable)(Value target))handle;
- (void)publishProtocolName:(NSString *)protocolName withIdentifier:(NSString * _Nullable)identifier withHandle:(void(^_Nullable)(Value target))handle;

//MARK: - 移除事件
/**
 销毁某个 target 订阅的所有事件
 
 @param target target description
 */
- (void) dispose:(id )target;

/**
 销毁某个事件

 @param marker marker description
 */
- (void) disposeEvent:(BCEvent *)marker;


@end


NS_ASSUME_NONNULL_END
