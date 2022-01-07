//
//  BCSwizzle.h
//  Pod
//
//  Created by Basic on 2016/11/11.
//  hook swizzle
//

#ifndef BCSwizzleDefine_h
#define BCSwizzleDefine_h

#import "RSSwizzle.h"
#import <objc/message.h>

#define BCHookClass(clsname)            objc_getClass(clsname)

#define BCHookSelector(selname)         NSSelectorFromString(selname)


#define BCSwizzle_SelfInstance        selfObj

#define BCSWReturnType(type) type

#define BCSWArguments(arguments...)    _RSSWArguments(arguments)

#define BCSWReplacement(code...)       code

#define BCSWCallOriginal(arguments...) \
((__typeof(originalImplementation_))[swizzleInfo getOriginalImplementation])(BCSwizzle_SelfInstance, selector_,##arguments) \

#define BCSwizzleInstanceMethod(classToSwizzle, selector, BCSWReturnType, BCSWArguments,BCSWReplacement) \
_BCSwizzleInstanceMethod(classToSwizzle, selector, BCSWReturnType, _RSSWWrapArg(BCSWArguments),_RSSWWrapArg(BCSWReplacement),RSSwizzleModeAlways,NULL) \

#define _BCSwizzleInstanceMethod(classToSwizzle, selector, BCSWReturnTypeV, BCSWArgumentsV,BCSWReplacementV,RSSwizzleModeV,KEY) \
do{\
if(classToSwizzle){\
Method BCMethod = class_getInstanceMethod(classToSwizzle, selector);\
if(BCMethod){ \
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Wunused-variable\"") \
[RSSwizzle swizzleInstanceMethod:selector inClass:[classToSwizzle class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) { \
BCSWReturnTypeV (*originalImplementation_)(_RSSWDel3Arg(__unsafe_unretained id, SEL, BCSWArgumentsV)); \
SEL selector_ = selector; \
return ^BCSWReturnTypeV (_RSSWDel2Arg(__unsafe_unretained id BCSwizzle_SelfInstance, BCSWArgumentsV)){ \
BCSWReplacementV \
}; \
} mode:RSSwizzleModeV key:KEY]; \
_Pragma("clang diagnostic pop")\
}\
}\
}while(0)


/*_RSSwizzleInstanceMethod(classToSwizzle,selector,BCSWReturnType, _RSSWWrapArg(BCSWArguments), _RSSWWrapArg(BCSWReplacement), RSSwizzleModeValue, key); \ */ \

#define BCSwizzleClassMethod(classToSwizzle, selector, BCSWReturnType, BCSWArguments,BCSWReplacement) \
_BCSwizzleClassMethod(classToSwizzle, selector, BCSWReturnType, _RSSWWrapArg(BCSWArguments),_RSSWWrapArg(BCSWReplacement))

#define _BCSwizzleClassMethod(classToSwizzle, selector, BCSWReturnType, BCSWArguments,BCSWReplacement) \
do{\
if(classToSwizzle){\
Class  BCcls = object_getClass(classToSwizzle);\
Method BCMethod = class_getInstanceMethod(BCcls, selector);\
if(BCMethod){ \
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Wunused-variable\"") \
[RSSwizzle swizzleClassMethod:selector inClass:[classToSwizzle class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) { \
BCSWReturnType (*originalImplementation_)(_RSSWDel3Arg(__unsafe_unretained id, SEL, BCSWArguments)); \
SEL selector_ = selector; \
return ^BCSWReturnType (_RSSWDel2Arg(__unsafe_unretained id BCSwizzle_SelfInstance, BCSWArguments)) { \
BCSWReplacement \
}; \
}]; \
_Pragma("clang diagnostic pop")\
}\
}\
}while(0)

#endif /* BCSwizzle_h */
