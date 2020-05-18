//
//  GXSingletonObject.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/11.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXSingletonObject.h"

@interface GXSingletonObject() <NSCopying>//为了打出来方法名

@end


@implementation GXSingletonObject
// 先设置下全局变量
// 加static就为了防止 extern 不让外界访问
static id instance_;

// share方法才是单例的初始化方法最佳方法,不推荐使用alloc init方法来初始化单例, 因为alloc调一次, init会多次调用
+ (instancetype)shareSingletonObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[super alloc] init];
    });
    return instance_;
}

// 从内存下手, 永远只分配一次内存
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    // 调用dispatch_one只跑一次方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*
         * 调用alloc时候, 系统会调用allocWithZone方法, 所以super alloc不严谨,
         * 你阻止不了被人调用withZone方法, 所以调withZone靠谱
         **/
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

// 防止外面调了copy方法, 不得不实现这个, 防止调copy崩了
- (id)copyWithZone:(NSZone *)zone
{
    return instance_;
}
@end
