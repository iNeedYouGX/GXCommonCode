//
//  BCFoundation.h
//  Pod
//
//  Created by Basic on 2017/3/7.
//  Copyright © 2017年 naruto. All rights reserved.
//  KDS foundation 基础类库 头文件

#ifndef BCFoundation_h
#define BCFoundation_h

#import "BCFoundationUtils.h"

// foundation
#import "NSObject+BCBlock.h"
#import "NSString+BCHelper.h"
#import "NSArray+BCHelper.h"
#import "NSDictionary+BCHelper.h"
#import "NSDate+BCHelper.h"
#import "NSNumber+BCHelper.h"
#import "NSNull+BCHelper.h"
#import "NSURL+BCHelper.h"

// uikit
#import "UIColor+BCHelper.h"
#import "UIImage+BCHelper.h"

//(兼容旧版本)
/// NSAttributedString 组件
#if __has_include(<BCFoundation/NSAttributedString+BCHelper.h>)
#import "NSAttributedString+BCHelper.h"
#import "NSMutableAttributedString+BCHelper.h"
#endif

/// Device 组件
#if __has_include(<BCFoundation/BCUUIDUtil.h>)
#import "BCUUIDUtil.h"
#import "UIDevice+BCHardware.h"
#endif


#endif /* BCFoundation_h */
