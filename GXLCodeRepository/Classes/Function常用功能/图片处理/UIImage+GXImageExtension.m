//
//  UIImage+GXImageExtension.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/20.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "UIImage+GXImageExtension.h"

@implementation UIImage (GXImageExtension)

#pragma mark - 图片改颜色
- (UIImage *)gx_imageWithTintColor:(UIColor *)tintColor
{
    // iOS 13系统方法叫imageWithTintColor
    // 获取画布
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    // Draw the tinted image in context
    // 绘制一次
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    
    // 再绘制一次
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    //获取图片
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
