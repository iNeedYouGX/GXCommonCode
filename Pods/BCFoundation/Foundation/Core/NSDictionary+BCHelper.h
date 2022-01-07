//
//  NSDictionary+BCHelper.h
//  Pod
//
//  Created by Basic on 15/1/25.
//  Copyright (c) 2015年 naruto. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (BCHelper)

#pragma mark - 转成JSON String

/**
 转成json字符串

 @return NSString
 */
-(NSString *)bc_toJsonString;

#pragma mark - 去除null

/**
 去除null 数据
 
 @return NSDictionary
 */
-(NSDictionary *)bc_removeNull;


/**
 根据url参数 初始化

 @param urlParams url查询参数
 @return return value description
 */
+ (instancetype )bc_dictionaryWithURLParams:(NSString *)urlParams;
@end

