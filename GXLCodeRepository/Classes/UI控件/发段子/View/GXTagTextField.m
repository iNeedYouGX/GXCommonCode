//
//  GXTagTextField.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/11/3.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXTagTextField.h"

@implementation GXTagTextField

/**
 * 知识点:  这个方法监听键盘的删除键
 */
- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
    NSLog(@"%@", self.text);
}

@end
