//
//  UITextView+BCLength.m
//  BCUIKit
//
//  Created by Basic. on 2019/11/16.
//

#import "UITextView+BCLength.h"
#import <objc/runtime.h>

@implementation UITextView (BCLength)

///MARK: -property
-(void)setBc_maxLength:(NSInteger)bc_maxLength {
    objc_setAssociatedObject(self, @selector(bc_maxLength), @(bc_maxLength), OBJC_ASSOCIATION_ASSIGN);
}
-(NSInteger)bc_maxLength {
    return [objc_getAssociatedObject(self, @selector(bc_maxLength)) integerValue];
}

- (BOOL)bc_validTextMaxLength {
    if (!self || self.bc_maxLength<1) {
        return NO;
    }
    CGFloat maxLength = self.bc_maxLength;
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange) {
        if (toBeString.length > maxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1) {
                self.text = [toBeString substringToIndex:maxLength];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
            return NO;
        }
    }
    return YES;
}

@end
