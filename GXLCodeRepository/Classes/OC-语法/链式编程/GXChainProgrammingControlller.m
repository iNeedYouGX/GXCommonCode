//
//  GXChainProgrammingControlller.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/6/18.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXChainProgrammingControlller.h"

@interface GXChainProgrammingControlller ()
/** <#注释#> */
@property (nonatomic, strong) NSMutableString *mutString;
@end

@implementation GXChainProgrammingControlller

- (NSMutableString *)mutString
{
    if (_mutString == nil) {
        _mutString = [[NSMutableString alloc] init];
    }
    return _mutString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addString(@"明天你好,").addString(@"我叫干不到");

    [self function:^int(int i) {
        // 所以让我来总结函数式编程当中的函数，可以一句话归结为：隔绝一切外部状态，传入值，输出值。
        return 3;
    }];
}

//一旦一个变量开始与=打交道，一旦变量的值会发生变化，我们就可以说这个变量有了状态。或者我们可以说，有=就有状态。

//不依赖外部状态: 外部修改不影响我

//不改变外部状态: 我不改变外部的状态

- (GXChainProgrammingControlller *(^)(NSString *))addString
{
    GXChainProgrammingControlller *(^block)(NSString *) = ^(NSString *string) {
        [self.mutString appendString:string];
        NSLog(@"-%@-", self.mutString);
        return self;
    };
    return block;
}


- (instancetype)function:(int (^)(int))param
{
    int result = param(8);
    
    return self;
}

@end
