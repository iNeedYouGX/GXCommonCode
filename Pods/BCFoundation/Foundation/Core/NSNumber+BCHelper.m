//
//  NSNumber+BCHelper.h
//  Pods
//
//  Created by Basic on 15/2/8.
//  Copyright (c) 2015年 Basic. All rights reserved.
//

#import "NSNumber+BCHelper.h"

@implementation NSNumber (BCHelper)
-(NSString *)bc_formatDigit:(int)digitNums {
    NSNumberFormatter *_format = [[NSNumberFormatter alloc]init];
    [_format setMaximumFractionDigits:digitNums];
    NSString *resultStr = [_format stringFromNumber:self];
    if (!resultStr) {
        resultStr = @"";
    }
    else if ([resultStr hasPrefix:@"."]) {
        //. 开头，手动加上0
        resultStr = [NSString stringWithFormat:@"0%@", resultStr];
    }
    return resultStr;
}
- (NSString *)bc_formatDecimal:(int )digitNums {
    NSNumberFormatter *_format = [[NSNumberFormatter alloc]init];
    [_format setMaximumFractionDigits:digitNums];
    [_format setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *resultStr = [_format stringFromNumber:self];
    if (!resultStr) {
        resultStr = @"";
    }
    return resultStr;
}

+(NSString *)bc_formatTwoDigit:(CGFloat )data {
    NSString *str = nil;
    if (fmodf(data, 1)==0) {
        str = [NSString stringWithFormat:@"%.0f",data];
    } else if (fmodf(data*10, 1)==0) {
        str = [NSString stringWithFormat:@"%.1f",data];
    } else {
        str = [NSString stringWithFormat:@"%.2f",data];
    }
    if (!str) {
        str = @"";
    }
    return str;
}

+(NSString *)bc_formatMoneyString:(CGFloat )money {
    NSString *valueStr = [NSString stringWithFormat:@"%lf", money];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:valueStr];
    NSNumberFormatter *numberFormatter =   [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@",###.##"];
    return [numberFormatter stringFromNumber:decNumber];
}
@end
