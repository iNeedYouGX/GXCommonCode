//
//  UIColor+BCHelper.m
//  Pods
//
//  Created by Basic on 2017/3/7.
//
//

#import "UIColor+BCHelper.h"

@implementation UIColor (BCHelper)


#pragma mark - class method
+(UIColor *)bc_colorWithRGB:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+(UIColor *)bc_colorWithRGB:(UInt32)rgbValue alpha:(CGFloat )alpha
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alpha];
}


+(UIColor *)bc_colorWithZFRGBA:(UInt32)hex
{
    int red, green, blue, alpha;
    blue = hex & 0x000000FF;
    green = ((hex & 0x0000FF00) >> 8);
    red = ((hex & 0x00FF0000) >> 16);
    alpha = ((hex & 0xFF000000) >> 24);
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha/255.f];
}


#pragma mark - other
+ (UIColor *)bc_colorWithRGBString:(NSString*)hexStr
{
    if (hexStr.length < 6)
        return nil;
    
    if ([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }
    
    unsigned int _red, _green, _blue;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]] scanHexInt:&_red];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]] scanHexInt:&_green];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]] scanHexInt:&_blue];
    
    UIColor* resultColor = [UIColor colorWithRed:_red/255. green:_green/255. blue:_blue/255. alpha:1.];
    return resultColor;
}

#pragma mark - random
+ (UIColor *)bc_randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
