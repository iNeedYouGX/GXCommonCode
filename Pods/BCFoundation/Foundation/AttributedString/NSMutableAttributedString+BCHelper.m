//
//  NSMutableAttributedString+BCHelper.m
//  Pods
//
//  Created by Basic on 2017/7/16.
//  基础组件
//  NSMutableAttributedString 扩展

#import "NSMutableAttributedString+BCHelper.h"
#import "NSAttributedString+BCHelper.h"
#import "NSString+BCHelper.h"

@implementation NSMutableAttributedString (BCHelper)

//MARK: - 更改颜色、字体
- (void )bc_changeColor:(UIColor *)color SubStringArray:(NSArray *)subArray {
    NSString *strAtrStr = [self string];
    for (NSString* rangeStr in subArray) {
        NSArray* array = [strAtrStr bc_rangeString:rangeStr];
        for (NSNumber* rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
}
- (void )bc_changeFont:(UIFont *)font SubStringArray:(NSArray *)subArray {
    NSString *strAtrStr = [self string];
    for (NSString* rangeStr in subArray) {
        NSArray* array = [strAtrStr bc_rangeString:rangeStr];
        for (NSNumber* rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            [self addAttribute:NSFontAttributeName value:font range:range];
        }
    }
}
- (void )bc_changeFontColor:(UIFont *)font Color:(UIColor *)color SubStringArray:(NSArray *)subArray {
    NSString *strAtrStr = [self string];
    for (NSString* rangeStr in subArray) {
        NSArray* array = [strAtrStr bc_rangeString:rangeStr];
        for (NSNumber* rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            [self addAttribute:NSForegroundColorAttributeName value:color range:range];
            [self addAttribute:NSFontAttributeName value:font range:range];
        }
    }
}
- (void )bc_changeColor:(UIColor *)color range:(NSRange )range {
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}
- (void )bc_changeFontColor:(UIFont *)font Color:(UIColor *)color range:(NSRange )range {
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    [self addAttribute:NSFontAttributeName value:font range:range];
}
- (void )bc_changeFont:(UIFont *_Nullable)font withColor:(UIColor *_Nullable)color withKeyword:(NSString *_Nullable)keyword withOtherAttr:(void(^_Nullable)(NSMutableAttributedString *attr, NSRange range) )otherAttr {
    if (!keyword) {
        return;
    }
    NSString *strAtrStr = [self string];
    NSArray *array = [strAtrStr bc_rangeString:keyword];
    for (NSNumber *rangeNum in array) {
        NSRange range = [rangeNum rangeValue];
        if (otherAttr) {
            otherAttr(self, range);
        }
        if (color) {
            [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        if (font) {
            [self addAttribute:NSFontAttributeName value:font range:range];
        }
    }
}

//MARK: - 追加文字
- (void )bc_appendAttribute:(NSString *_Nullable)keyword withFont:(UIFont *_Nullable)font withColor:(UIColor *_Nullable)color {
    if (!keyword || keyword.length <=0) { return; }
    NSAttributedString *newAttributeStr = [NSAttributedString bc_initFont:font Color:color TotalString:keyword];
    if (newAttributeStr) {
        [self appendAttributedString:newAttributeStr];
    }
}
- (void)bc_appendAttribute:(NSString *)keyword withFont:(UIFont *)font withColor:(UIColor *)color withOtherAttr:(void (^)(NSMutableAttributedString * _Nonnull))otherAttr {
    if (!keyword || keyword.length <=0) { return; }
    NSMutableAttributedString *newAttributeStr = [NSMutableAttributedString bc_initFont:font Color:color TotalString:keyword];
    if (otherAttr) {
        otherAttr(newAttributeStr);
    }
    if (newAttributeStr) {
        [self appendAttributedString:newAttributeStr];
    }
}

//MARK: - 计算size
- (CGSize )bc_autoSize:(CGSize)maxSize withLineSpace:(CGFloat )lineSpace {
    if (lineSpace>0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    }
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}
- (CGFloat )bc_autoHeight:(CGFloat)maxWidth withLineSpace:(CGFloat )lineSpace {
    if (lineSpace>0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    }
    CGFloat contentHeight = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    return contentHeight;
}
@end
