//
//  GXPlaceholderTextView.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/30.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXPlaceholderTextView.h"

@interface GXPlaceholderTextView ()
/** 提示文字 */
@property (nonatomic, strong) UILabel *placeLabel;
@end

@implementation GXPlaceholderTextView
- (UILabel *)placeLabel
{
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.numberOfLines = 0;
        _placeLabel.x = 4;
        _placeLabel.y = 7;
        [self addSubview:_placeLabel];
    }
    return _placeLabel;
}

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
         * 第一种方式: self.delegate = self, 不推荐, 如果外面设置代理, 内部代理不起作用
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
    self.placeLabel.hidden = self.hasText;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.placeLabel.textColor = placeHolderColor;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeLabel.text = placeHolder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeLabel.font = font;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeLabel.width = SCR_WIDTH - 2 * _placeLabel.x;
    [self.placeLabel sizeToFit];
}

/**
 * setNeedsDisplay : 会调用 drawRect:(CGRect)rect
 * setNeedsLayout : 会调用 layoutSubviews
 */

@end
