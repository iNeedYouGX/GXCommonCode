//
//  UITextView+BCLength.h
//  BCUIKit
//
//  Created by Basic. on 2019/11/16.
//  字符长度

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (BCLength)

/// 最大长度，自动截取
@property (assign, nonatomic) NSInteger bc_maxLength;

///  验证最大字符数，自动截取 返回 YES，表示未超过最大字符数；返回 NO，表示超过最大字符数，并自动截取
- (BOOL)bc_validTextMaxLength;

@end

NS_ASSUME_NONNULL_END
