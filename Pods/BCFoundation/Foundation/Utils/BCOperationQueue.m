//
//  BCOperationQueue.m
//  BCFoundation
//
//  Created by Basic on 2018/1/12.
//

#import "BCOperationQueue.h"
#import "BCFoundationUtils.h"


@interface BCOperationQueue()
@property (nonatomic, strong) NSMutableArray<BCOperation *>  *queueOperations;//所有的任务
@property (nonatomic, strong) NSMutableArray<BCOperation *>  *excutingOperations;//正在执行的任务
@property (nonatomic, strong) dispatch_semaphore_t  excutingLock;//执行中任务的锁
@end



@implementation BCOperationQueue

#pragma mark - system
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.name = @"com.zh.queue";
        [self setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (void)dealloc
{
    BCLogDealloc();
}

#pragma mark - getter
-(NSMutableArray<BCOperation *> *)excutingOperations
{
    if (!_excutingOperations) {
        _excutingOperations = [[NSMutableArray alloc] init];
    }
    return _excutingOperations;
}

-(NSMutableArray<BCOperation *> *)queueOperations
{
    if (!_queueOperations) {
        _queueOperations = [[NSMutableArray alloc] init];
    }
    return _queueOperations;
}

-(dispatch_semaphore_t)excutingLock
{
    if (!_excutingLock) {
        _excutingLock = dispatch_semaphore_create(1);
    }
    return _excutingLock;
}
-(NSArray<BCOperation *> *)bc_excutings
{
    NSArray *bc_excutingsTemp = nil;
    dispatch_semaphore_wait(self.excutingLock, DISPATCH_TIME_FOREVER);
    bc_excutingsTemp = [self.excutingOperations copy];
    dispatch_semaphore_signal(self.excutingLock);
    return bc_excutingsTemp;
}

-(NSArray<BCOperation *> *)bc_operations
{
    NSArray *bc_operationsTemp = nil;
    dispatch_semaphore_wait(self.excutingLock, DISPATCH_TIME_FOREVER);
    bc_operationsTemp = [self.queueOperations copy];
    dispatch_semaphore_signal(self.excutingLock);
    return bc_operationsTemp;
}

#pragma mark - 添加一个自定义操作
- (void)bc_addOperation:(void (^)(BCOperation *, void (^)(void)))operationBlock
{
    [self bc_addOperation:nil withForceExcute:NO withBlock:operationBlock];
}

- (void)bc_addOperation:(NSString *)operationId withForceExcute:(BOOL)forceExcute withBlock:(void (^)(BCOperation *, void (^)(void)))operationBlock
{
    BCOperation *operation = [[BCOperation alloc] init];
    operation.operationId = operationId;
    operation.foreExcute = forceExcute;
    if (forceExcute) {//强制执行的优先级要高
        operation.queuePriority = NSOperationQueuePriorityHigh;
    } else {
        operation.queuePriority = NSOperationQueuePriorityNormal;
    }
    BCWeakObj(self);
    [operation setZhOperationBlock:^(BCOperation *operation, void (^zhcompletionBlock)(void)) {
        BCStrongObj(self);
        [self bc_startExcuting:operation];
        if (operationBlock) {
            operationBlock(operation, ^(void){
                [self bc_endExcuting:operation];
                if (zhcompletionBlock) {
                    zhcompletionBlock();
                }
            });
        }
    }];
    
    dispatch_semaphore_wait(self.excutingLock, DISPATCH_TIME_FOREVER);
    if (operation.operationId.length<=0) {//没有唯一标识符，可以重复添加
        [self.queueOperations addObject:operation];
        [self addOperation:operation];
        dispatch_semaphore_signal(self.excutingLock);
        return;
    }
    //存在唯一标识符，需要去重
    NSInteger findIndex = -1;
    BCOperation *findOperation = nil;//查找是否已经有该任务了
    for (BCOperation *operationTemp in self.queueOperations) {
        findIndex++;
        if([operationTemp.operationId isEqualToString:operation.operationId]) {
            findOperation = operationTemp;
            break;
        }
    }
    if (!findOperation) {
        //不在队列里，添加任务
        [self.queueOperations addObject:operation];
        [self addOperation:operation];
        //判断是否需要强制执行，且有没有超过并发数
        if (operation.foreExcute && self.excutingOperations.count>=self.maxConcurrentOperationCount) {
            //需要移除第一个执行中的任务，这样就会执行 上面添加的任务
            BCOperation *firstOperation = self.excutingOperations.firstObject;
            [firstOperation cancel];
            [self.excutingOperations removeObjectAtIndex:0];
        }
    } else {
        //已经在队列里，还在排队等待执行，且需要强制执行的，那么需要把待执行的cancel，开始执行新的
        if (operation.foreExcute && !findOperation.isExecuting && !findOperation.isFinished  && !findOperation.isCancelled) {
            [self.queueOperations addObject:operation];
            [self addOperation:operation];
            [self.queueOperations removeObjectAtIndex:findIndex];
        }
        BCLog(@"bcoperation exsit:%@,%d,%d", operation.operationId, operation.foreExcute, findOperation.isExecuting);
    }
    dispatch_semaphore_signal(self.excutingLock);
}

#pragma mark - operation 队列


/**
  开始执行任务
 */
- (void )bc_startExcuting:(BCOperation *)operation
{
    dispatch_semaphore_wait(self.excutingLock, DISPATCH_TIME_FOREVER);
    [self.excutingOperations addObject:operation];
    dispatch_semaphore_signal(self.excutingLock);
}



/**
 任务执行结束
 */
- (void )bc_endExcuting:(BCOperation *)operation
{
    dispatch_semaphore_wait(self.excutingLock, DISPATCH_TIME_FOREVER);
    [self.excutingOperations removeObject:operation];
    [self.queueOperations removeObject:operation];
    dispatch_semaphore_signal(self.excutingLock);
}


@end
