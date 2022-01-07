//
//  NSAttributedString+BCHelper.m
//  Pods
//
//  Created by Basic on 2017/4/1.
//  基础组件
//  NSAttributedString 扩展

#import "NSAttributedString+BCHelper.h"
#import "NSString+BCHelper.h"
#import <CoreText/CTStringAttributes.h>

@implementation NSAttributedString (BCHelper)

//MARK: - 更改颜色、字体
+ (instancetype )bc_initColor:(UIColor *)color TotalString:(NSString *)totalString
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, totalString.length)];
    return attributedStr;
}

+ (instancetype )bc_initFont:(UIFont *)font TotalString:(NSString *)totalString
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    [attributedStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, totalString.length)];
    return attributedStr;
}

+ (instancetype )bc_initFont:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, totalString.length)];
    }
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, totalString.length)];
    }
    return attributedStr;
}

+ (instancetype )bc_changeColor:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    for (NSString* rangeStr in subArray) {
        NSArray* array = [totalString bc_rangeString:rangeStr];
        for (NSNumber* rangeNum in array) {
            NSRange range = [rangeNum rangeValue];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    return attributedStr;
}
+ (instancetype) bc_initString:(NSString*)totalString withSpace:(CGFloat)space {
    return [self bc_initString:totalString withSpace:space font:nil];
}
+ (instancetype) bc_initString:(NSString*)totalString withSpace:(CGFloat)space font:(UIFont *)font {
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [totalString length])];
    }
    return [[NSAttributedString alloc] initWithAttributedString:attributedStr];
}
+ (instancetype)bc_initText:(NSString *)text image:(UIImage *)image onLeft:(BOOL)left {
    if (!text) {
        text = @"";
    }
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    // -2 Y坐标修正值
    attachment.bounds = CGRectMake(0, -2, image.size.width, image.size.height);
    
    NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:attachment];
    if (left) {
        NSMutableAttributedString *mAttributedStr = [[NSMutableAttributedString alloc] initWithAttributedString:attachmentAttributedString];
        NSMutableAttributedString *textAttributedStr = [[NSMutableAttributedString alloc] initWithString:text];
        [mAttributedStr appendAttributedString:textAttributedStr];
        return [[NSAttributedString alloc] initWithAttributedString:mAttributedStr];
    }else{
        NSMutableAttributedString *contentAttributedStr = [[NSMutableAttributedString alloc] initWithString:text];
        [contentAttributedStr appendAttributedString:attachmentAttributedString];
        return [[NSAttributedString alloc] initWithAttributedString:contentAttributedStr];
    }
}

#pragma mark - 修改行间距
+ (NSAttributedString *)bc_changeSpaceWithTotalString:(NSString*)totalString Space:(CGFloat)space
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    long number = space;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributedStr length])];
    CFRelease(num);
    return [[NSAttributedString alloc] initWithAttributedString:attributedStr];
}

+ (NSAttributedString *)bc_changeLineSpaceWithTotalString:(NSString*)totalString LineSpace:(CGFloat)lineSpace
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    return [[NSAttributedString alloc] initWithAttributedString:attributedStr];
}

+ (NSAttributedString *)bc_changeLineSpaceWithTotalString:(NSString*)totalString LineSpace:(CGFloat)lineSpace font:(UIFont *)font
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    [attributedStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [totalString length])];
    return [[NSAttributedString alloc] initWithAttributedString:attributedStr];
}

+ (NSAttributedString *)bc_changeLineAndTextSpaceWithTotalString:(NSString*)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace
{
    if (!totalString) {
        totalString = @"";
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributedStr length])];
    CFRelease(num);
    
    return [[NSAttributedString alloc] initWithAttributedString:attributedStr];
}

//MARK: - 计算高度
- (CGFloat )bc_autoHeight:(CGFloat)maxWidth {
    CGFloat contentHeight = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    return contentHeight;
}
@end
