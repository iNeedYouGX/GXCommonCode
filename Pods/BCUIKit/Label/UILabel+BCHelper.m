//
//  UILabel+BCHelper.m
//  Pod
//
//  Created by Basic on 2016/11/16.
//  Copyright © 2016年 naruto. All rights reserved.
//

#import "UILabel+BCHelper.h"
#import <BCFoundation/UIColor+BCHelper.h>


@implementation UILabel (BCHelper)
+ (instancetype)bc_allocLable:(void (^)(UILabel* label))configureBlock
{
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.textAlignment = NSTextAlignmentLeft;
//    label.font = [UIFont systemFontOfSize:14];
    if (configureBlock) {
        configureBlock(label);
    }
    return label;
}
- (void)bc_setText:(NSString *)text withLineSpacing:(CGFloat)space {
    if (!text) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
    
}
@end
