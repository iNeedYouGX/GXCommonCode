//
//  GXMenuLabel.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/22.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXMenuLabel.h"

@implementation GXMenuLabel

/** 重写两个方法, 使用xib和init创建时候, 都要能用 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 把用户响应打开
    self.userInteractionEnabled = YES;
    
    // 添加轻拍事件
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
}

- (void)labelClick
{
    // 让label成为响应者, 成为了响应者, 可以调用两个方法: 通过这个两个方法, 设置具体响应事件(cut, paste等等)
    [self becomeFirstResponder];
    
    // 创建MenuController
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 自定义menuItem
    /**
     * 自定义之后, 实现方法不放到控制器中是出不来的, 系统是交给第一响应者的控制器来处理的, 得将ding, replly, report的方法实现放到控制器中, 所以如果是之定义, 就把下面的也写到控制器中, 自定义label然并软
     */
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply)];
    UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report)];
    menu.menuItems = @[item1, item2, item3];
    
    
    // menu控制的弹出的位置, 在哪个View上什么位置Rect
    [menu setTargetRect:self.bounds inView:self];
    
    // menu显示
    [menu setMenuVisible:YES animated:YES];
}

// 第一个方法: 设置可不可以成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

// 第二个方法: 判断执行的方法有哪些, 可以筛选(copy, paste等等)
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(action));
//     实现剪切, 复制, 粘贴功能
    if (action == @selector(cut:) || action == @selector(paste:) || action == @selector(copy:)) {
        return YES; // 显示
    } else {
        return NO; // 不显示
    }
}




/**
 * 注意点, 如果现实了下面的这些方法, 可以不用写上面的筛选了, 系统会根据具体实现的方法来判断, 应给显示什么
 */
// 复制
- (void)copy:(UIMenuController *)sender
{
    // 拿到粘贴板, 赋值
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
}

// 剪切
- (void)cut:(UIMenuController *)sender
{
    [self copy:sender];
    self.text = @"";
}

// 粘贴
- (void)paste:(UIMenuController *)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    self.text = pasteboard.string;

}

@end

