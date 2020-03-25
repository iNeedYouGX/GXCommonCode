//
//  GXButtons.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/19.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXButtons.h"

@interface GXButtons ()
/** void */
@property (nonatomic, strong) void (^block)(UIButton *);
@end

@implementation GXButtons

+ (instancetype)buttonWithFrame:(CGRect)rect title:(NSString *)title bColor:(UIColor *)backColor color:(UIColor *)color font:(UIFont *)font cornerRadius:(CGFloat)cornerRadius
                     eventBlock:(void (^)(UIButton *))block
{

    GXButtons *backView = [[GXButtons alloc] init];
    backView.block = block;
    backView.frame = rect;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.size = rect.size;
    btn.frame = rect;
    btn.backgroundColor = backColor;
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [backView addSubview:btn];
    btn.layer.cornerRadius = cornerRadius;
    [btn addTarget:backView action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    return backView;
}
- (void)action:(UIButton *)sender
{
    !self.block ? : self.block(sender);
}

@end
