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
- (UIImage *)gx_changeImageWithTintColor:(UIColor *)tintColor
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

#pragma mark - 图片改亮度
- (UIImage *)gx_changeImageBright
{
    CGImageRef ref = self.CGImage;
    //使用CGImage初始化CIImage对象
    CIImage *image = [CIImage imageWithCGImage:ref];
    //创建一个滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    //利用键值对来设置滤镜的属性（后面的key在CIFilter中都可以找到，然后拿到这些key进行相应的赋值即可）
    [filter setValue:image forKey:kCIInputImageKey];

    CGFloat number = 0.1;
//    number ++;
    //设置图片的亮度
    [filter setValue:@(number)  forKey:kCIInputBrightnessKey];
    
    //得到滤镜处理后的CIImage
    CIImage *imageOut = [filter outputImage];
    //初始化CIContext对象
    CIContext *context = [CIContext contextWithOptions:nil];
    //利用CIContext对象渲染后得到CGImage，最后将它转成UIImage
    CGImageRef outImage = [context createCGImage:imageOut fromRect:imageOut.extent];
    UIImage *outPutImage = [UIImage imageWithCGImage:outImage];
    //释放CGImage对象，一定不要忘记自己释放
    CGImageRelease(outImage);
    //将转好的UIImage添加到UIImageView中进行显示
    return outPutImage;
}

@end
