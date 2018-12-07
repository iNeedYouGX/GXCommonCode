//
//  GXFooterView.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/25.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXFooterView.h"

@implementation GXFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        [self createSquare:10];
    }
    return self;
}

// 总页数 = (总数 + 每页最大数 - 1) / 每页最大数
- (void)createSquare:(NSInteger)count
{
    // 最大列数
    NSInteger maxCols = 4;
    
    // 按钮的宽高
    CGFloat WH = SCR_WIDTH / 4;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
        
        NSInteger col = i % maxCols;
        NSInteger row = i / maxCols;
    
        btn.x = col * WH;
        btn.y = row * WH;
        btn.width = WH;
        btn.height = WH;
        
        [self addSubview:btn];
        
        self.height = CGRectGetMaxY(btn.frame);
    }
}

// 技术点: 这个方法可以设置背景图, 哈哈, 挺有意思
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"image.jpeg"];
    [image drawInRect:rect];
}

@end
