//
//  NSNull+BCHelper.h
//  Pods
//
//  Created by Basic on 15/2/8.
//  Copyright (c) 2015年 Basic. All rights reserved.
//


#import "NSNull+BCHelper.h"

#define kNSNullObjects @[@"",@0,@{},@[]]

@implementation NSNull (BCHelper)

//- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
//{
//    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
//    if (!signature) {
//        for (NSObject *object in kNSNullObjects) {
//            signature = [object methodSignatureForSelector:selector];
//            if (signature) {
//                break;
//            }
//        }
//
//    }
//    return signature;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    SEL aSelector = [anInvocation selector];
//
//    for (NSObject *object in kNSNullObjects) {
//        if ([object respondsToSelector:aSelector]) {
//            [anInvocation invokeWithTarget:object];
//            return;
//        }
//    }
//
//    [self doesNotRecognizeSelector:aSelector];
//}


@end
