//
//  NSObject+Block.m
//  taxi2
//
//  Created by Basic on 6/6/14.
//  延迟执行 block，注意block循环引用
//

#import "NSObject+BCBlock.h"

@implementation NSObject (BCBlock)
#pragma mark - private
static inline dispatch_time_t dTimeDelay(NSTimeInterval time)
{
    int64_t delayInSeconds = time*NSEC_PER_SEC;
    return  dispatch_time(DISPATCH_TIME_NOW,delayInSeconds);
}

#pragma mark - public
- (id)bc_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    if (!block) return nil;
    if(delay<=0){
        block();
        return nil;
    }
    else{
        __block BOOL cancelled = NO;
        void (^wrappingBlock)(BOOL cancel) = ^(BOOL cancel) {
            if (cancel) {
                cancelled = YES;
                return;
            }
            if (!cancelled) block();
        };
        dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO); });
        return wrappingBlock;
    }
}
- (id)bc_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay
{
    if (!block) return nil;
    if(delay<=0){
        block(anObject);
        return nil;
    }
    else{
        __block BOOL cancelled = NO;
        void (^wrappingBlock)(BOOL cancel, id arg) = ^(BOOL cancel, id arg) {
            if (cancel) {
                cancelled = YES;
                return;
            }
            if (!cancelled) block(arg);
        };
        dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO, anObject); });
        return wrappingBlock;
    }
}
+ (void)bc_cancelBlock:(id)block
{
    if (!block) return;
    void (^aWrappingBlock)(BOOL cancel) = (void(^)(BOOL cancel))block;
    aWrappingBlock(YES);
}
@end
