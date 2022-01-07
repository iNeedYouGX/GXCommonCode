//
//  BCEventBusHelper.m
//  BCEventBus
//
//  Created by Basic on 2019/9/26.
//

#import "BCEventBusHelper.h"

@interface BCEventBusHelper()

@end

@implementation BCEventBusHelper


#pragma mark - helper
+ (NSString *)getEventNameWithStr:(NSString *)name {
    NSString *eventName = nil;
    if (name.length>0) {
        eventName = [NSString stringWithFormat:@"Str_%@", name];
    }
    return eventName;
}
+ (NSString *)getEventNameWithClass:(Class )eventClass {
    if (!eventClass) {
        return nil;
    }
    NSString *eventName = NSStringFromClass(eventClass);
    //加上前追
    if (eventName.length>0) {
        eventName = [NSString stringWithFormat:@"Obj_%@", eventName];
    }
    return eventName;
}
+ (NSString *)getEventNameWithClassName:(NSString *)clsName {
    if (!clsName) {
        return nil;
    }
    if (clsName.length>0) {
        clsName = [NSString stringWithFormat:@"Obj_%@", clsName];
    }
    return clsName;
}
+ (NSString *)getEventNameWithProtocol:(Protocol *)protocol {
    if (!protocol) {
        return nil;
    }
    NSString *eventName = nil;
    eventName = NSStringFromProtocol(protocol);
    //加上前追
    if (eventName.length>0) {
        eventName = [NSString stringWithFormat:@"Pro_%@", eventName];
    }
    return eventName;
}
+ (NSString *)getEventNameWithProtocolName:(NSString *)protocolName {
    NSString *eventName = nil;
    //加上前追
    if (protocolName.length>0) {
        eventName = [NSString stringWithFormat:@"Pro_%@", protocolName];
    }
    return eventName;
}

@end
