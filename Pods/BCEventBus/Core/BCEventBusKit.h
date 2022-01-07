//
//  BCEventBusKit.h
//  BCRouteKit
//
//  Created by Basic on 2018/11/19.
//

#ifndef BCEventBusKit_h
#define BCEventBusKit_h

#import "BCEventBus.h"

//MARK: - 字符串事件
//订阅某个字符串事件
#define BCSubName(_target_, _name_) ((BCEvent *)[BCEventBus.shareBus subscribeName:_name_ withTarget:_target_])
//发布字符串事件
#define BCPubName(_name_) [BCEventBus.shareBus publishName:_name_ withData:nil]
#define BCPubNameWithData(_name_,_data_) [BCEventBus.shareBus publishName:_name_ withData:_data_]

//MARK: - class 事件
//订阅某一类特定的事件，class方式
#define BCSubClass(_target_, _eventClass_) ((BCEvent<_eventClass_ *> *)[BCEventBus.shareBus subscribeClass:[_eventClass_ class] withIdentifier:nil withTarget:_target_])
#define BCSubClassIdentifier(_target_, _eventClass_, _identifierObj_) ((BCEvent<_eventClass_ *> *)[BCEventBus.shareBus subscribeClass:[_eventClass_ class] withIdentifier:[NSString stringWithFormat:@"%p",_identifierObj_] withTarget:_target_])
//发布对象事件
#define BCPubEvent(_event_) [BCEventBus.shareBus publish:_event_]
#define BCPubClass(_class_, _event_) [BCEventBus.shareBus publishClass:[_class_ class] withEvent:_event_]
#define BCPubClassIdentifier(_class_, _event_, _identifierObj_) [BCEventBus.shareBus publishClass:[_class_ class] withIdentifier:[NSString stringWithFormat:@"%p",_identifierObj_] withEvent:_event_]
#define BCPubClassName(_className_, _event_) [BCEventBus.shareBus publishClass:NSClassFromString(_className_) withEvent:_event_]

//MARK: - Protocol 事件
//订阅某一组事件，协议的方式
#define BCSubProtocol(_target_, _protocol_) [BCEventBus.shareBus subscribeProtocol:@protocol(_protocol_) withTarget:_target_]
#define BCSubProtocolIdentifier(_target_, _protocol_, _identifier_) [BCEventBus.shareBus subscribeProtocol:@protocol(_protocol_) withIdentifier:_identifier_ withTarget:_target_]
//发布协议事件
#define BCPubProtocol(_protocol_) (BCEventBus<id<_protocol_> > *)BCEventBus.shareBus publishProtocol:@protocol(_protocol_)

#pragma mark - 销毁事件
//销毁target的所有事件，一般不需要手动调用，事件会伴随订阅者一起销毁。
#define BCDisposeEvent(_target_) [BCEventBus.shareBus dispose:_target_]

#endif /* BCEventBusKit_h */
