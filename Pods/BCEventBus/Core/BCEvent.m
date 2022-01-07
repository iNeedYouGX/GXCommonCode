//
//  BCEvent.m
//  BCRouteKit
//
//  Created by Basic on 2018/11/13.
//

#import "BCEvent.h"
#import "BCEventBus.h"

@interface BCEvent()
@end

@implementation BCEvent
#pragma mark - system
- (void)dealloc
{
//#ifdef DEBUG
//    NSLog(@"BCEvent dealloc");
//#endif
}

#pragma mark - setter
-(void)setNext:(BCEventHandleBlock)handle {
    _handle = handle;
}
- (void)sendNext:(id)event {
    if (_handle) {
        _handle(event);
    }
}

#pragma mark - 销毁事件
- (void) dispose {
    [BCEventBus.shareBus dispose:self];
    _target = nil;
    _eventName = nil;
    _handle = nil;
}

@end
