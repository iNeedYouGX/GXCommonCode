//
//  UITextField+BCHelper.m
//  Pods
//
//  Created by Basic on 2017/8/14.
//
//

#import "UITextField+BCHelper.h"
#import <BCFoundation/NSString+BCHelper.h>
#import <objc/runtime.h>
#import <BCFoundation/BCSwizzle.h>
#import <BCComConfigKit/BCComConfigKit.h>

@implementation UITextField (BCHelper)

#pragma mark - system
+ (void)load
{
    BCSwizzleInstanceMethod([UITextField class], BCHookSelector(@"init"), BCSWReturnType(UITextField *), BCSWArguments(), BCSWReplacement({
        UITextField *hh_tf = BCSWCallOriginal();
        if ([hh_tf respondsToSelector:@selector(hh_tfInit)]) {
            [hh_tf hh_tfInit];
        }
        return hh_tf;
    }));
    BCSwizzleInstanceMethod([UITextField class], BCHookSelector(@"initWithFrame"), BCSWReturnType(UITextField *), BCSWArguments(CGRect frame), BCSWReplacement({
        UITextField *hh_tf = BCSWCallOriginal(frame);
        if ([hh_tf respondsToSelector:@selector(hh_tfInit)]) {
            [hh_tf hh_tfInit];
        }
        return hh_tf;
    }));
}

- (void )hh_tfInit
{
    if (BCComConfig.config.tfTintColor) {
        self.tintColor = BCComConfig.config.tfTintColor;
    }
}



///MARK:- 设置颜色
-(void)setBc_placeholderColor:(UIColor *)bc_placeholderColor
{
    objc_setAssociatedObject(self, @selector(bc_placeholderColor), bc_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIColor *)bc_placeholderColor
{
    return objc_getAssociatedObject(self, @selector(bc_placeholderColor));
}

///MARK:- 设置字体
-(void)setBc_placeholderFont:(UIFont *)bc_placeholderFont
{
    objc_setAssociatedObject(self, @selector(bc_placeholderFont), bc_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIFont *)bc_placeholderFont
{
    return objc_getAssociatedObject(self, @selector(bc_placeholderFont));
}

///MARK: - 更新 Placeholder
- (void)bc_updatePlaceholder
{
    if(self.placeholder.length<=0){
        return;
    }
    NSMutableDictionary *mdictProptery = [[NSMutableDictionary alloc] init];
    if(self.bc_placeholderFont){
        mdictProptery[NSFontAttributeName] = [self bc_placeholderFont];
    }
    else{
        mdictProptery[NSFontAttributeName] = self.font;
    }
    mdictProptery[NSForegroundColorAttributeName] = [self bc_placeholderColor];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:mdictProptery];
    [self setAttributedPlaceholder:attrString];
}

///MARK: - 最大字节限制
-(void)setBc_maxLength:(NSInteger)bc_maxLength {
    objc_setAssociatedObject(self, @selector(bc_maxLength), @(bc_maxLength), OBJC_ASSOCIATION_ASSIGN);
    if (bc_maxLength>0) {
        [self addTarget:self action:@selector(bc_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    } else {
        [self removeTarget:self action:@selector(bc_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
}
-(NSInteger)bc_maxLength {
    return [objc_getAssociatedObject(self, @selector(bc_maxLength)) integerValue];
}
- (BOOL)bc_validMaxLength:(NSUInteger )maxLength
{
    NSString *toBeString = self.text;
    NSInteger charLength = [toBeString bc_length];
    NSString *lang = [self.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]){// 简体中文输入
        //获取高亮部分
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position){
            if (charLength > maxLength){
                self.text = [toBeString bc_substringToIndex:maxLength];
                return NO;
            }
        }
    } 
    else{// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (charLength > maxLength){
            self.text = [toBeString bc_substringToIndex:maxLength];
            return NO;
//            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:length];
//            if (rangeIndex.length == 1){
//                self.text = [toBeString substringToIndex:length];
//            }
//            else{
//                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, length)];
//                self.text = [toBeString substringWithRange:rangeRange];
//            }
        }
    }
    return YES;
}

/**
 文本内容改变

 @param textField textField description
 */
-(void)bc_textFieldDidChange:(UITextField *)textField
{
    CGFloat maxLength = self.bc_maxLength;
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange) {
        if (toBeString.length > maxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1) {
                textField.text = [toBeString substringToIndex:maxLength];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    if (self.bc_disableEmoji) {
        textField.text = [NSString bc_disableEmojiWith:textField.text];
    }
}
///MARK: - emoji
-(void)setBc_disableEmoji:(BOOL)bc_disableEmoji{
    objc_setAssociatedObject(self, @selector(bc_disableEmoji), @(bc_disableEmoji), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)bc_disableEmoji {
    return [objc_getAssociatedObject(self, @selector(bc_disableEmoji)) boolValue];
}

@end
