//
//  NSString+CZExtension.h
//  BestCity
//
//  Created by JasonBourne on 2018/8/9.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CZExtension)
- (NSMutableAttributedString *)addStrikethroughWithRange:(NSRange)range;

- (NSMutableAttributedString *)addAttributeColor:(UIColor *)color Range:(NSRange)range;
- (NSMutableAttributedString *)addAttributeFont:(UIFont *)Font Range:(NSRange)range;
- (NSMutableAttributedString *)addAttribute:(NSDictionary *)attributs Range:(NSRange)range;

- (NSString *)setupTextRowSpace;
- (CGFloat)getTextHeightWithRectSize:(CGSize)size andFont:(UIFont *)font;
+ (instancetype)gx_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
+ (instancetype)gx_stringWithMoreString:(NSString *)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
@end

