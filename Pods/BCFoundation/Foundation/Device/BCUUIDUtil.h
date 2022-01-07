#import <Foundation/Foundation.h>
//
//  BCUUIDUtil.h
//  Pod
//
//  Created by Basic on 2017/3/7.
//  Copyright © 2017年 naruto. All rights reserved.
//  uuid 帮助类

NS_ASSUME_NONNULL_BEGIN
@interface BCUUIDUtil : NSObject
#pragma mark - public
/**
 保存数据

 @param service service description
 @param data data description
 */
+ (void )bc_save:(NSString *)service data:(id)data;

/**
 加载数据

 @param service service description
 @return return value description
 */
+ (id )bc_load:(NSString *)service;

/**
 删除数据

 @param service service description
 */
+ (void )bc_deleteData:(NSString *)service;

/**
 获取uuid

 @return return value description
 */
+ (NSString *)bc_uuid;
@end

NS_ASSUME_NONNULL_END
