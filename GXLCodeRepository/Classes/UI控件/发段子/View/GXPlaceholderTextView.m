//
//  GXPlaceholderTextView.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/30.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXPlaceholderTextView.h"

@implementation GXPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 竖直位置要有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 默认的字体
        self.font = [UIFont systemFontOfSize:17];
        
        // 默认的字体颜色
        self.placeHolderColor = [UIColor lightGrayColor];
        /**
         * 在内部监听文字的输入
         * 第一种方式: self.delegate = self, 这种方式不好, 如果外面将代理方法给变, 内部这个代理就不好使了(所以这种方式不好)
         * 第二种方式: 用系统内部的通知
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textViewChange:(NSNotification *)center
{
//    [NSNotificationCenter defaultCenter] postNotificationName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#> userInfo:<#(nullable NSDictionary *)#>;
    /**
     * NSNottification中有几个属性
     * 1. name : 这个是监听的通知的名字 "UITextViewTextDidChangeNotification"
     * 2. object : 这个就是这个监听着self
     * 3. userInfo : 发送通知时候, 带的userInfo参数
     */
    NSLog(@"%@", center.userInfo);
    
    // 重新绘制站位文字
    [self setNeedsDisplay];
    
}

/**
 * 绘制站位文字
 */
- (void)drawRect:(CGRect)rect {
//     如果textView有文字,直接返回
//    if (self.text.length || self.attributedText.length) return;
    if (self.hasText) return;
    
    rect.origin.y = 7;
    rect.origin.x = 4;
    rect.size.width -= 2 * rect.origin.x;
    
    NSMutableDictionary *attribut = [NSMutableDictionary dictionary];
    attribut[NSFontAttributeName] = self.font;
    attribut[NSForegroundColorAttributeName] = self.placeHolderColor;
    
    [self.placeHolder drawInRect:rect withAttributes:attribut];
 
}

/**
 * setNeedsDisplay : 会调用 drawRect:(CGRect)rect
 * setNeedsLayout : 会调用 layoutSubviews
 */

@end
