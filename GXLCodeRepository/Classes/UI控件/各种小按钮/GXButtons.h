//
//  GXButtons.h
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/19.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXButtons : UIView
+ (instancetype)buttonWithFrame:(CGRect)rect title:(NSString *)title bColor:(UIColor *)backColor color:(UIColor *)color font:(UIFont *)font cornerRadius:(CGFloat)cornerRadius
eventBlock:(void (^)(UIButton *))block;
@end

NS_ASSUME_NONNULL_END
