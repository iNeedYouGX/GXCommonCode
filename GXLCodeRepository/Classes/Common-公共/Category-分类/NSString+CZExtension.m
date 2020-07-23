//
//  NSString+CZExtension.m
//  BestCity
//
//  Created by JasonBourne on 2018/8/9.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "NSString+CZExtension.h"

@implementation NSString (CZExtension)

void foo (NSString *firstObj, ...)
{
    NSLog(@"ddddd");
}

+ (instancetype)gx_stringWithMoreString:(NSString *)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    // 创建列表指针
    va_list ap;
    
    // ap指针指向firstObj
    va_start(ap, firstObj);
    
    // 临时指针变量
    id temp;
    
    // VA_ARG宏，获取可变参数的当前参数，返回指定类型并将指针指向下一参数
    // 首先 ap指向一大堆参数的第一个, 如果不为nil(就是不为nil就行)则将值取出, 并将指针指向下一个参数, 这样每次循环, 直到取出nil
    while ((temp = va_arg(ap, NSString *))) {
        NSLog(@"%@",temp);
    }
    va_end(ap);
    return @"";
}

//    参数说明：
//
//    NS_FORMAT_FUNCTION(1, 2) 告诉编译器，索引1处的参数是一个格式化字符串，而实际参数从索引2处开始
//    va_list 定义一个指向个数可变的参数列表的指针，这个参数列表指针就是 arglist
//    va_start 使参数列表指针指向 format，从 format 的下一个元素开始（必须有）
//    va_end 结束，清空 va_list 可变参数列表（必须有）
+ (instancetype)gx_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    va_list ap;
    va_start(ap, format);
    
    id temp;
    while ((temp = va_arg(ap, NSString *))) {
        
            NSLog(@"%@",temp);
    }
    
    // 这里必须使用可变字符串，不然随机崩溃，原因嘛，是因为与系统的一些方法冲突了
    NSMutableString *result = [[NSMutableString alloc] initWithFormat:format arguments:ap];
    NSLog(@"myStringWithFormat: %@", result);
    va_end(ap);
    
    if (result.length >= 6) {
        if ([result containsString:@"(null)"]) {
            NSString *string = [result stringByReplacingCharactersInRange:[result rangeOfString:@"(null)"] withString:@""];
            result = (NSMutableString *)string;
        }
    }
    return result;
}

//返回一个中划线的富文本
- (NSMutableAttributedString *)addStrikethroughWithRange:(NSRange)range
{
    NSDictionary *att = @{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttributes:att range:range];
    return attrStr;
}

//添加文字颜色
- (NSMutableAttributedString *)addAttributeColor:(UIColor *)color Range:(NSRange)range
{
    NSDictionary *att = @{NSForegroundColorAttributeName : color};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttributes:att range:range];
    return attrStr;
}

//添加文字大小
- (NSMutableAttributedString *)addAttributeFont:(UIFont *)Font Range:(NSRange)range
{
    NSDictionary *att = @{NSFontAttributeName : Font};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttributes:att range:range];
    return attrStr;
}

// 添加各种属性
- (NSMutableAttributedString *)addAttribute:(NSDictionary *)attributs Range:(NSRange)range
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttributes:attributs range:range];
    return attrStr;
}

// 设置文字间距
- (NSString *)setupTextRowSpace
{
    NSString *string;
    if (self.length == 3) {
        string = [NSString stringWithFormat:@"%@  %@  %@", [self substringWithRange:NSMakeRange(0, 1)], [self substringWithRange:NSMakeRange(1, 1)], [self substringWithRange:NSMakeRange(2, 1)] ];
    } else if (self.length == 2) {
        string = [NSString stringWithFormat:@"%@        %@", [self substringWithRange:NSMakeRange(0, 1)], [self substringWithRange:NSMakeRange(1, 1)]];
    } else {
        string = self;
    }
    return string;
}

- (CGFloat)getTextHeightWithRectSize:(CGSize)size andFont:(UIFont *)font
{
    CGFloat contentlabelHeight = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size.height;
    return contentlabelHeight;
}

@end
