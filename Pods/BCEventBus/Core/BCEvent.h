//
//  BCEvent.h
//  BCRouteKit
//
//  Created by Basic on 2018/11/13.
//  事件标记，订阅一次，产生一个标记，也可以当做RACSubject使用

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCEvent<Value> : NSObject
/** 事件target，如果target销毁，监听的事件也自动销毁 */
@property (nonatomic, weak) NSObject *target;
/** 事件 名称 */
@property (nonatomic, copy) NSString *eventName;
/** 事件子名称 */
@property (nonatomic, strong) NSString *subName;

typedef void (^BCEventHandleBlock)(Value _Nullable event);
/** 某个具体事件的handle */
@property (nonatomic, copy, nullable) BCEventHandleBlock handle;

#pragma mark - 事件回调

/**
 设置 next 事件

 @param handle 事件回调
 */
-(void)setNext:(BCEventHandleBlock )handle;

/**
 手动触发 next 事件

 @param event 事件对象
 */
-(void)sendNext:(nullable Value )event;

#pragma mark - 销毁

/**
 订阅销毁
 */
- (void) dispose;

@end


NS_ASSUME_NONNULL_END
