//
//  NSArray+BCHelper.h
//  Pods
//
//  Created by Basic on 15/2/8.
//  Copyright (c) 2015年 Basic. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSArray (BCHelper)

#pragma mark - 去除null

/**
 去除null 数据
 
 @return NSDictionary
 */
-(NSMutableArray *)bc_removeNull;

/**
 转成json string

 @return return value description
 */
- (NSString *)bc_toJson;

#pragma mark - safe

/**
 返回安全的对应位置数据

 @param idx 下标
 @return return value description
 */
- (id)bc_safeObjectAtIndex:(NSUInteger)idx;

@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(BCHelper)

/**
 安全的addObject，先判断nil

 @param anObject anObject description
 */
-(void)bc_addObject:(id)anObject;
@end


#pragma --mark  NSOrderedSet

@interface NSOrderedSet(BCHelper)

#pragma mark - safe
/**
 返回安全的对应位置数据
 
 @param idx 下标
 @return return value description
 */
- (id)bc_safeObjectAtIndex:(NSUInteger)idx;

@end
