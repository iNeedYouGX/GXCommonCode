//
//  BCOperationQueue.h
//  BCFoundation
//
//  Created by Basic on 2018/1/12.
//  基础组件 - 自定义 operation queue

#import <Foundation/Foundation.h>
#import "BCOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCOperationQueue : NSOperationQueue
@property (nonatomic, strong, readonly, nullable) NSArray<BCOperation *>  *bc_excutings;//正在执行的任务
@property (nonatomic, strong, readonly, nullable) NSArray<BCOperation *>  *bc_operations;//所有任务

#pragma mark - 添加一个自定义操作

/**
 添加一个自定义operation

 @param operationBlock operationBlock description
 */
- (void)bc_addOperation:(void (^_Nullable)(BCOperation *operation, void (^_Nullable zhcompletionBlock)(void) ) )operationBlock;


/**
 添加一个自定义operation

 @param operationId 唯一id
 @param forceExcute 是否强制执行，yes，会立即执行，如果超过并发数，会取消第一个在执行的task
 @param operationBlock operationBlock description
 */
- (void)bc_addOperation:(NSString *_Nullable)operationId withForceExcute:(BOOL)forceExcute withBlock:(void (^_Nullable)(BCOperation *operation, void (^_Nullable zhcompletionBlock)(void)))operationBlock;
@end
NS_ASSUME_NONNULL_END
