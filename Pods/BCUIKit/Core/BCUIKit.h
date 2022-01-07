//
//  BCUIKit.h
//  BCFoundation
//
//  Created by Basic on 2018/11/20.
//

#ifndef BCUIKit_h
#define BCUIKit_h

#import "UIBarButtonItem+BCHelper.h"
#import "UINavigationItem+BCHelper.h"
#import "UINavigationBar+BCHelper.h"
#import "UIView+BCHelper.h"
#import "UIButton+BCHelper.h"

/// Controller 组件
#if __has_include(<BCUIKit/UIViewController+HHPage.h>)
#import "UIViewController+HHPage.h"
#import "UINavigationController+HHUIKit.h"
#endif

/// alert 组件
#if __has_include(<BCUIKit/UIAlertController+BCHelper.h>)
#import "UIAlertController+BCHelper.h"
#endif
/// input 组件
#if __has_include(<BCUIKit/UITextView+BCPlaceHolder.h>)
#import "UITextView+BCPlaceHolder.h"
#import "UITextField+BCHelper.h"
#endif
/// label 组件
#if __has_include(<BCUIKit/UILabel+BCHelper.h>)
#import "UILabel+BCHelper.h"
#endif

#endif /* BCUIKit_h */
