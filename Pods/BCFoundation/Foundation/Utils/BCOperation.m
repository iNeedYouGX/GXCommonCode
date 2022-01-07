//
//  BCOperation.m
//  Group
//
//  Created by Basic on 2017/12/27.
//  Copyright © 2017年 Basic. All rights reserved.
//

#import "BCOperation.h"
#import "BCFoundationUtils.h"

@interface BCOperation()
@property (nonatomic, getter = isFinished, readwrite)   BOOL finished;/**< 是否在完成 */
@property (nonatomic, getter = isExecuting, readwrite)  BOOL executing;/**< 是否在执行 */
@end



@implementation BCOperation
@synthesize finished  = _finished;
@synthesize executing = _executing;

#pragma mark - system
- (instancetype)init
{
    self = [super init];
    if (self) {
        _finished  = NO;
        _executing = NO;
    }
    return self;
}

- (void)start
{
    if ([self isCancelled]) {
        self.finished = YES;
        return;
    }
    if (_zhOperationBlock) {
        BCWeakObj(self);
        _zhOperationBlock(self, ^(void){
            BCStrongObj(self);
            [self onOpeationComplate];
        });
    }
    self.executing = YES;
}
-(void)dealloc
{
    BCLogDealloc();
}

#pragma mark - NSOperation methods
- (BOOL)isExecuting
{
    @synchronized(self) {
        return _executing;
    }
}
- (BOOL)isFinished
{
    @synchronized(self) {
        return _finished;
    }
}
- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing) {
        [self willChangeValueForKey:@"isExecuting"];
        @synchronized(self) {
            _executing = executing;
        }
        [self didChangeValueForKey:@"isExecuting"];
    }
}
- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    @synchronized(self) {
        if (_finished != finished) {
            _finished = finished;
        }
    }
    [self didChangeValueForKey:@"isFinished"];
}

-(void)cancel
{
    [super cancel];
}

#pragma mark - 请求完成回调

/**
 请求operation完成的回调

 */
- (void)onOpeationComplate
{
    //通知operation 完成
    self.executing = NO;
    self.finished  = YES;
}



@end
