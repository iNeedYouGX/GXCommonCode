//
//  GXPlaceholderTextView.h
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/30.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXPlaceholderTextView : UITextView
/** 提示文字 */
@property (nonatomic, strong) NSString *placeHolder;
/** 提示文字颜色 */
@property (nonatomic, strong) UIColor *placeHolderColor;
@end

NS_ASSUME_NONNULL_END
