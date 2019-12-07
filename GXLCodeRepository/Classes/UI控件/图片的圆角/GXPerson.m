//
//  GXPerson.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/5/21.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXPerson.h"

@interface GXPerson () <NSCopying> // Copying协议
@property (nonatomic, copy) NSString *string; // strong copy它是为了set方法赋值策略的u不同
@end

@implementation GXPerson

- (void)setString:(NSString *)string
{
    _string = [string copy];
}

- (id)copyWithZone:(nullable NSZone *)zone // 实现copyWithZone方法
{
    GXPerson *p = [[GXPerson alloc] init]; // 重新初始化一个当前类
    p.age = self.age; // 将属性赋值
    return p;
}

void copyProperty()
{
    
}
@end
