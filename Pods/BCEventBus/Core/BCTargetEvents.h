//
//  BCTargetEvents.h
//  BCRouteKit
//
//  Created by Basic on 2018/11/19.
//  target 目标订阅的所有事件

#import <Foundation/Foundation.h>
#import "BCEvent.h"

@interface BCTargetEvents : NSObject
#pragma mark - 初始化

/**
 根据target 初始化

 @param target target description
 @return return value description
 */
- (instancetype)initWithTarget:(id )target;

#pragma mark - 添加 event

/**
 添加event marker

 @param marker marker description
 */
- (void) addEventMarker:(BCEvent *)marker;
@end

