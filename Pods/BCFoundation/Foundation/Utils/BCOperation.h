//
//  BCOperation.h
//  Group
//
//  Created by Basic on 2017/12/27.
//  Copyright © 2017年 Basic. All rights reserved.
//  基础组件 - 自定义 operation

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCOperation : NSOperation
/// 唯一的标识id
@property (nonatomic, copy, nullable) NSString *operationId;
/// 是否强制执行，默认NO。YES：被加入的operation会立即执行，超过并发数的时候，取消队列中第一个task
@property (nonatomic, assign) BOOL  foreExcute;
/// operation  执行的动作
@property (nonatomic, copy, nullable) void(^zhOperationBlock)(BCOperation *operation, void(^_Nullable completeBlock)(void));
@end

NS_ASSUME_NONNULL_END
