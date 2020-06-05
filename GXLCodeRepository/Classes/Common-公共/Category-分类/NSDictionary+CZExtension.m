//
//  NSDictionary+CZExtension.m
//  BestCity
//
//  Created by JasonBourne on 2018/11/27.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "NSDictionary+CZExtension.h"

@implementation NSDictionary (CZExtension)
- (NSDictionary *)changeAllStringValue
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *keyStr in mutableDic.allKeys) {
            
        id object = [mutableDic objectForKey:keyStr];
        
        if ([object isKindOfClass:[NSDictionary class]]) { // 如果是NSDictionary类型
            NSDictionary *dic = [object changeAllStringValue];
            [mutableDic setObject:dic forKey:keyStr];
        } else if ([object isKindOfClass:[NSNull class]]) { // 如果是NSNull类型
//            NSString *objectStr = [NSString stringWithFormat:@"%@", object];
//            [mutableDic setObject:objectStr forKey:keyStr];
            [mutableDic removeObjectForKey:keyStr];
        } else if ([object isKindOfClass:[NSNumber class]]) { // 如果是NSNumber类型
            NSString *objectStr = [NSString stringWithFormat:@"%@", object];
            [mutableDic setObject:objectStr forKey:keyStr];
        } else if ([object isKindOfClass:[NSString class]]) { // 如果是NSString类型
            [mutableDic setObject:object forKey:keyStr];
        } else if ([object isKindOfClass:[NSArray class]]) { // 如果是NSArray类型
            NSArray *objectArr = [self changeArray:object];
            [mutableDic setObject:objectArr forKey:keyStr];
        }
    }
    return mutableDic;
}



- (NSArray *)changeArray:(NSArray *)arr
{
    NSMutableArray *objectArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {  // 如果是NSDictionary类型
            NSDictionary *dic = [obj changeAllStringValue];
            [objectArr addObject:dic];
        } else if ([obj isKindOfClass:[NSString class]]) {  // 如果是NSString类型
            [objectArr addObject:obj];
        } else if ([obj isKindOfClass:[NSNumber class]]) {  // 如果是NSNumber类型
            NSString *objStr = [NSString stringWithFormat:@"%@", obj];
            [objectArr addObject:objStr];
        } else if ([obj isKindOfClass:[NSArray class]]) {  // 如果是NSArray类型
            NSArray *objArr = [self changeArray:obj];
            [objectArr addObject:objArr];
        }else if ([obj isKindOfClass:[NSNull class]]) { // 如果是NSNull类型
//            NSString *objStr = [NSString stringWithFormat:@"%@", obj];
//            [objectArr addObject:objStr];
        }
    }];
    return objectArr;
}



/** 删除为null的数据 */
- (NSDictionary *)deleteAllNullValue
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *keyStr in mutableDic.allKeys) {
        if ([[mutableDic objectForKey:keyStr] isEqual:[NSNull null]]) {
//            [mutableDic setObject:@"" forKey:keyStr];
            [mutableDic removeObjectForKey:keyStr];
        } else {
            [mutableDic setObject:[mutableDic objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}

/** 改变为Number的数据 */
- (NSDictionary *)changeAllNnmberValue
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:[self deleteAllNullValue]];
    for (NSString *keyStr in mutableDic.allKeys) {
        id value = [mutableDic objectForKey:keyStr];
        if ([value isKindOfClass:[NSNumber class]]) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
            // 小数位最多位数
            numberFormatter.maximumFractionDigits = 2;
            numberFormatter.minimumFractionDigits = 2;

            NSString *formattedNumberString = [numberFormatter stringFromNumber:value];
            [mutableDic setObject:[NSString stringWithFormat:@"%@", formattedNumberString] forKey:keyStr];
        } else {
            [mutableDic setObject:value forKey:keyStr];
        }
    }
    return mutableDic;
}

/** 将数据为sh */
- (NSDictionary *)changeAllValueWithString
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithDictionary:[self deleteAllNullValue]];
    for (NSString *keyStr in mutableDic.allKeys) {
        id value = [mutableDic objectForKey:keyStr];
        if (![value isKindOfClass:[NSString class]]) {
            NSString *stringValue = [NSString stringWithFormat:@"%@", value];
            NSArray *arr = [stringValue componentsSeparatedByString:@"."];
            if (arr.count > 1){
                NSString *str = arr[1];
                if (str.length <= 2) {
                    [mutableDic setObject:stringValue forKey:keyStr];
                } else {
                    NSString *currentValue = [NSString stringWithFormat:@"%@.%@", arr[0], [str substringToIndex:2]];
                    [mutableDic setObject:currentValue forKey:keyStr];
                }
            } else {
                [mutableDic setObject:stringValue forKey:keyStr];
            }
        } else {
            [mutableDic setObject:value forKey:keyStr];
        }
    }
    return mutableDic;
}
@end
