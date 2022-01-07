//
//  NSObject+Block.h
//  taxi2
//
//  Created by Basic on 6/6/14.
//  延迟执行 block，注意block循环引用
//

#import <Foundation/Foundation.h>
@interface NSObject (BCBlock)

/**
 延迟执行 block

 @param block block description
 @param delay delay description
 @return 返回的block 可用于取消用
 */
- (id)bc_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

/**
 延迟执行 block

 @param block block description
 @param anObject anObject description
 @param delay delay description
 @return 返回的block 可用于取消用
 */
- (id)bc_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;


/**
 取消 block

 @param block 需要取消的block对象
 */
+ (void)bc_cancelBlock:(id)block;

@end
