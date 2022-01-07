//
//  BCEventBus.m
//  BCRouteKit
//
//  Created by Basic on 2018/11/13.
//

#import "BCEventBus.h"
#import "NSObject+BCEventHelper.h"
#import "BCEventBusHelper.h"

@interface BCEventBus()
/** 事件集合 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<BCEvent *> *> *eventMap;
@end


@implementation BCEventBus
#pragma mark - system
+ (BCEventBus *)shareBus {
    static BCEventBus *kBCEventBusInstance = nil;
    static dispatch_once_t kBCEventBusOnceToken;
    dispatch_once(&kBCEventBusOnceToken, ^{
        kBCEventBusInstance = [[BCEventBus alloc] init];
    });
    return kBCEventBusInstance;
}

//MARK: - setter
-(NSMutableDictionary<NSString *,NSMutableArray<BCEvent *> *> *)eventMap {
    if (!_eventMap) {
        _eventMap = [[NSMutableDictionary alloc] init];
    }
    return _eventMap;
}

//MARK: - class 事件
- (BCEvent *)subscribeClass:(Class)eventCls withTarget:(id)target {
    return [self subscribeClass:eventCls withIdentifier:nil withTarget:target];
}
- (BCEvent *)subscribeClass:(Class)eventCls withIdentifier:(NSString *)identifier withTarget:(id)target {
    //获取 event Name
    NSString *eventName = [BCEventBusHelper getEventNameWithClass:eventCls];
    if (eventName.length<=0) {
#ifdef DEBUG
        NSLog(@"[eventbus] subscribe event error,name null");
#endif
        return nil;
    }
    BCEvent *marker = [[BCEvent alloc] init];
    marker.eventName = eventName;
    marker.target = target;
    marker.subName = identifier;
    //添加到target的事件 队列中，方便target销毁的时候，自动销毁事件
    if (marker.target) {
        [marker.target.bc_events addEventMarker:marker];
    }
    //添加到列表
    NSMutableArray<BCEvent *> *subscriberList = self.eventMap[eventName];
    if (!subscriberList) {
        subscriberList = [NSMutableArray array];
        self.eventMap[eventName] = subscriberList;
    }
    [subscriberList addObject:marker];
    return marker;
}
- (void)publish:(id)event {
    [self publishClass:[event class] withIdentifier:nil withEvent:event];
}
- (void)publishClass:(Class)eventCls withEvent:(id)event {
    [self publishClass:eventCls withIdentifier:nil withEvent:event];
}
- (void)publishClass:(Class )eventCls withIdentifier:(NSString * _Nullable)identifier withEvent:(id _Nullable)event {
    if (!eventCls && !event) {
        return;
    }
    if (!eventCls && event) {
        eventCls = [event class];
    }
    NSString *eventName = [BCEventBusHelper getEventNameWithClass:eventCls];
    if (eventName.length <= 0) {
#ifdef DEBUG
        NSLog(@"[eventbus] publish event error,name null");
#endif
        return;
    }
    //遍历订阅者，分发事件
    NSMutableArray<BCEvent *> *subscriberList = self.eventMap[eventName];
    if (subscriberList.count<=0) {
        return;
    }
    NSMutableArray<BCEvent *> *subscriberListCopy = [subscriberList mutableCopy];
    for (BCEvent *subscriber in subscriberListCopy) {
        if (identifier == nil) {
            //通知所有的事件，不区分二级事件名称
            subscriber.handle(event);
        }
        else if (identifier != nil && [identifier isEqualToString:subscriber.subName]) {
            //匹配对应的是二级事件
            subscriber.handle(event);
        }
    }
}

//MARK: - 字符串事件
- (BCEvent *)subscribeName:(NSString *)eventName withTarget:(id)target {
    //获取 event Name
    eventName = [BCEventBusHelper getEventNameWithStr:eventName];
    if (eventName.length<=0) {
#ifdef DEBUG
        NSLog(@"[eventbus] subscribe name error,name null");
#endif
        return nil;
    }
    BCEvent *marker = [[BCEvent alloc] init];
//    marker.eventClass = [NSString class];
    marker.target = target;
    //添加到target的事件 队列中，方便target销毁的时候，自动销毁事件
    if (marker.target) {
        [marker.target.bc_events addEventMarker:marker];
    }
    //添加到列表
    NSMutableArray<BCEvent *> *subscriberList = self.eventMap[eventName];
    if (!subscriberList) {
        subscriberList = [NSMutableArray array];
        self.eventMap[eventName] = subscriberList;
    }
    [subscriberList addObject:marker];
    return marker;
}
- (void)publishName:(NSString *)eventName withData:(id )data {
    eventName = [BCEventBusHelper getEventNameWithStr:eventName];
    if (eventName.length <= 0) {
#ifdef DEBUG
        NSLog(@"[eventbus] publish name error,name null");
#endif
        return;
    }
    //遍历订阅者，分发事件
    NSMutableArray<BCEvent *> *subscriberList = self.eventMap[eventName];
    if (subscriberList.count<=0) {
        return;
    }
    NSMutableArray<BCEvent *> *subscriberListCopy = [subscriberList mutableCopy];
    for (BCEvent *subscriber in subscriberListCopy) {
        if (subscriber.handle) {
            subscriber.handle(data);
        }
    }
}


//MARK: - protocol 事件
- (void)subscribeProtocol:(Protocol *)protocol withTarget:(id)target {
    if (!protocol) {
        return;
    }
    [self subscribeProtocolName:NSStringFromProtocol(protocol) withIdentifier:nil withTarget:target];
}
- (void)subscribeProtocol:(Protocol *)protocol withIdentifier:(NSString *)identifier withTarget:(id)target {
    [self subscribeProtocolName:NSStringFromProtocol(protocol) withIdentifier:identifier withTarget:target];
}
- (void)subscribeProtocolName:(NSString *)protocolName withTarget:(id)target {
    [self subscribeProtocolName:protocolName withIdentifier:nil withTarget:target];
}
- (void)subscribeProtocolName:(NSString *)protocolName withIdentifier:(NSString * _Nullable)identifier  withTarget:(id)target{
    if (!protocolName) {
        return;
    }
    //获取 event Name
    NSString *eventName = [BCEventBusHelper getEventNameWithProtocolName:protocolName];
    if (eventName.length<=0) {
#ifdef DEBUG
        NSLog(@"[eventbus] subscribe protocol error,name null");
#endif
        return;
    }
    BCEvent *marker = [[BCEvent alloc] init];
    marker.eventName = eventName;
    marker.target = target;
    marker.subName = identifier;
    //添加到target的事件 队列中，方便target销毁的时候，自动销毁事件
    if (marker.target) {
        [marker.target.bc_events addEventMarker:marker];
    }
    //添加到列表
    NSMutableArray<BCEvent *> *subscriberList = self.eventMap[eventName];
    if (!subscriberList) {
        subscriberList = [NSMutableArray array];
        self.eventMap[eventName] = subscriberList;
    }
    [subscriberList addObject:marker];
}

- (void)publishProtocol:(Protocol *)protocol withHandle:(BCEventProtocolBlock )handle {
    if (!protocol) {
        return;
    }
    [self publishProtocolName:NSStringFromProtocol(protocol) withIdentifier:nil withHandle:handle];
}
- (void)publishProtocol:(Protocol *)protocol withIdentifier:(NSString *)identifier withHandle:(BCEventProtocolBlock )handle {
    [self publishProtocolName:NSStringFromProtocol(protocol) withIdentifier:identifier withHandle:handle];
}
- (void)publishProtocolName:(NSString *)protocolName withHandle:(BCEventProtocolBlock )handle {
    [self publishProtocolName:protocolName withIdentifier:nil withHandle:handle];
}
- (void)publishProtocolName:(NSString *)protocolName withIdentifier:(NSString * _Nullable)identifier withHandle:(BCEventProtocolBlock )handle {
    NSString *eventName = [BCEventBusHelper getEventNameWithProtocolName:protocolName];
    if (eventName.length <= 0) {
#ifdef DEBUG
        NSLog(@"[eventbus] publish protocol error,name null");
#endif
        return;
    }
    if (!handle) {
        return;
    }
    //遍历订阅者，分发事件
    NSMutableArray<BCEvent *> *subscriberList = self.eventMap[eventName];
    if (subscriberList.count<=0) {
        return;
    }
    NSMutableArray<BCEvent *> *subscriberListCopy = [subscriberList mutableCopy];
    for (BCEvent *subscriber in subscriberListCopy) {
        if (identifier == nil) {
            //通知所有的事件，不区分二级事件名称
            if (subscriber.target) {
                handle(subscriber.target);
            }
        }
        else if (identifier != nil && [identifier isEqualToString:subscriber.subName]) {
            //匹配对应的是二级事件
            if (subscriber.target) {
                handle(subscriber.target);
            }
        }
    }
}


//MARK: - 移除事件
- (void) dispose:(id )target {
    //存储需要清空的事件列表
    NSMutableArray<NSString *> *delEvents = nil;
    //遍历事件map，找到对应的target的所有event的marker列表
    for (NSString *key in self.eventMap.allKeys) {
        NSMutableArray<BCEvent *> *obj = self.eventMap[key];
        NSMutableArray<BCEvent *> *delMarkerList = nil;
        for (BCEvent *marker in obj) {
            //找到target匹配的项 | target为空的项
            if ((marker.target && marker.target == target) || !marker.target) {
                if (!delMarkerList) {
                    delMarkerList = [[NSMutableArray alloc] init];
                }
                [delMarkerList addObject:marker];
            }
        }
        //删除监听的事件
        if (delMarkerList.count>0) {
            [obj removeObjectsInArray:delMarkerList];
        }
        //如果该事件没有监听者了，则标记需要清空
        if (obj.count<=0) {
            if (!delEvents) {
                delEvents = [[NSMutableArray alloc] init];
            }
            [delEvents addObject:key];
        }
    }
    //清空 空的event
    if (delEvents.count>0) {
        for (NSString *eventKey in delEvents) {
            [self.eventMap removeObjectForKey:eventKey];
        }
    }
}
- (void) disposeEvent:(BCEvent *)marker {
    NSString *eventName = marker.eventName;
    if (eventName.length <= 0) {
#ifdef DEBUG
        NSLog(@"[eventbus] dispose error,name null");
#endif
        return;
    }
    NSMutableArray<BCEvent *> *subscriberList = self.eventMap[eventName];
    if (subscriberList.count<=0) {
        return ;
    }
    NSMutableArray<BCEvent *> *delMarkers = [[NSMutableArray alloc] init];
    for (BCEvent *subscriber in subscriberList) {
        if (subscriber == marker) {
            //对象地址一样
            [delMarkers addObject:subscriber];
            continue;
        } else if(subscriber.target && marker.target && subscriber.target == marker.target && subscriber.eventName &&  marker.eventName && [subscriber.eventName isEqualToString: marker.eventName]) {
            //target、eventName 一样
            [delMarkers addObject:subscriber];
            continue;
        }
    }
    //删除找到的 marker
    if (delMarkers.count>0) {
        [subscriberList removeObjectsInArray:delMarkers];
    }
    //如果事件列表为空，清空该项事件
    if (subscriberList.count<=0) {
        [self.eventMap removeObjectForKey:eventName];
    }
}


@end
