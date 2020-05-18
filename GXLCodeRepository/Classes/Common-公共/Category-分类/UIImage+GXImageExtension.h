//
//  UIImage+GXImageExtension.h
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/20.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GXImageExtension)
// 图片改颜色
- (UIImage *)gx_changeImageWithTintColor:(UIColor *)tintColor;
// 图片改亮度
- (UIImage *)gx_changeImageBright;
@end

NS_ASSUME_NONNULL_END
