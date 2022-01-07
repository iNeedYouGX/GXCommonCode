//
//  UIColor+BCHelper.h
//  Pods
//
//  Created by Basic on 2017/3/7.
//
//

#import <UIKit/UIKit.h>


#define kBCRGBColor(rgb)                [UIColor bc_colorWithRGB:rgb]
#define kBCRGBAColor(rgb,alphaValue)    [UIColor bc_colorWithRGB:rgb alpha:(alphaValue)]
#define kBCRGBStrColor(rgbStr)          [UIColor bc_colorWithRGBString:rgbStr]
#define kBCColorFromRGB(r, g, b)        [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (BCHelper)

/**
 把16进制6位颜色转换成UIColor

 @param hex 16进制6位颜色数字，0xFFFF00
 @return UIColor
 */
+ (UIColor *)bc_colorWithRGB:(UInt32)hex;

/**
 根据rgb 和alpha 创建颜色

 @param rgbValue rgbValue description
 @param alpha alpha description
 @return return value description
 */
+(UIColor *)bc_colorWithRGB:(UInt32)rgbValue alpha:(CGFloat )alpha;

+(UIColor *)bc_colorWithRGBString:(NSString *)hexStr;

/**
 把16进制8位颜色转换成UIColor

 @param hex 16进制8位颜色数字，0xFFFF0000
 @return UIColor
 */
+ (UIColor *)bc_colorWithZFRGBA:(UInt32) hex;

/**
 随机颜色

 @return UIColor
 */
+ (UIColor *)bc_randomColor;

@end


NS_ASSUME_NONNULL_END
