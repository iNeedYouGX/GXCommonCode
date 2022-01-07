//
//  NSDictionary+BCHelper.m
//  Pod
//
//  Created by Basic on 15/1/25.
//  Copyright (c) 2015年 naruto. All rights reserved.
//

#import "NSDictionary+BCHelper.h"
#import "NSArray+BCHelper.h"

@implementation NSDictionary (BCHelper)

#pragma mark - 转成JSON String

-(NSString *)bc_toJsonString
{
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
}

#pragma mark - 去除null
-(NSDictionary *)bc_removeNull
{
    NSMutableDictionary *mdictSelf = nil;
    if([self isKindOfClass:[NSMutableDictionary class]] || [self isKindOfClass:[NSDictionary class]]){
        if([self isKindOfClass:[NSDictionary class]]){
            mdictSelf = [[NSMutableDictionary alloc] initWithDictionary:self];
        }
        else{
            mdictSelf = (NSMutableDictionary *)self;
        }
        for(NSString *key in [mdictSelf allKeys]) {
            id object = mdictSelf[key];
            if([object isKindOfClass:[NSNull class]]) {
                mdictSelf[key] = nil;
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    mdictSelf[key] = nil;
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *subArray = (NSArray*)object;
                subArray = [subArray bc_removeNull];
                mdictSelf[key] = subArray;
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *subDict = (NSDictionary*)object;
                subDict = [subDict bc_removeNull];
                mdictSelf[key] = subDict;
            }
        }
    }
    return mdictSelf;
}

+ (instancetype )bc_dictionaryWithURLParams:(NSString *)urlParams
{
    if (urlParams == nil || [urlParams isEqualToString:@""]) {
        return nil;
    }
    NSArray *aArr = [urlParams componentsSeparatedByString:@"&"];
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (NSString *string in aArr) {
        NSArray *strArr = [string componentsSeparatedByString:@"?"];
        if (strArr.count > 0) {
            [mArr addObjectsFromArray:strArr];
        }
    }
    NSMutableDictionary *parameterDict = [NSMutableDictionary dictionary];
    for (int i = 0; i < mArr.count; i++) {
        NSArray *str = [mArr[i] componentsSeparatedByString:@"="];
        if (str.count == 2) {
            NSString *value = str[1];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
            [parameterDict setObject:value forKey:str[0]];
        }
        else if (str.count > 2){
            
            NSMutableString *appending = [[NSMutableString alloc] initWithCapacity:0];
            for (NSUInteger j = str.count - 1; j == 1; j--) {
                [appending appendString:str[j]];
            }
            
            NSString *value = [appending copy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [parameterDict setObject:value forKey:str[0]];
#pragma clang diagnostic pop
        }
        else {
#ifdef DEBUG
            NSLog(@"没有等号的参数跳过");
#endif
        }
    }
    return parameterDict;
}
@end

