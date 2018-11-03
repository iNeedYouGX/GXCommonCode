//
//  GXTagTextField.h
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/11/3.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXTagTextField : UITextField
/** 键盘删除的方法 */
@property (nonatomic, copy) void (^deleteBlock)(void);
@end

NS_ASSUME_NONNULL_END
