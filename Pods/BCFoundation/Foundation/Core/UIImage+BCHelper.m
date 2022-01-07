#import "UIImage+BCHelper.h"
#import "UIColor+BCHelper.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (BCHelper)

///MARK: - 缩放到制定大小

- (UIImage *)bc_scaleFitToSize:(CGSize)size {
    
    CGFloat scaleRate = MIN(size.width / self.size.width, size.height / self.size.height);
    return [self bc_scaleImageToSize:size rate:scaleRate];
}

- (UIImage *)bc_scaleFillToSize:(CGSize)size {
    
    CGFloat scaleRate = MAX(size.width / self.size.width, size.height / self.size.height);
    return [self bc_scaleImageToSize:size rate:scaleRate];
}

- (UIImage *)bc_scaleImageToSize:(CGSize)size rate:(CGFloat)scaleRate {
    
    UIImage *image = nil;
    CGSize renderSize = CGSizeMake(self.size.width * scaleRate, self.size.height * scaleRate);
    CGFloat startX = size.width * 0.5 - renderSize.width * 0.5;
    CGFloat startY = size.height * 0.5 - renderSize.height * 0.5;
    
    CGImageAlphaInfo info = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = (info == kCGImageAlphaNone) || (info == kCGImageAlphaNoneSkipFirst) || (info == kCGImageAlphaNoneSkipLast);
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.);
    UIColor *backgroundColor = opaque ? [UIColor whiteColor] : [UIColor clearColor];
    [backgroundColor setFill];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, size.width, size.height), kCGBlendModeNormal);
    
    [self drawInRect:CGRectMake(startX, startY, renderSize.width, renderSize.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)bc_scaleWithMaxWidth:(CGFloat)width
{
    CGFloat imageWidth = self.size.width;
    if (imageWidth < width) {
        return self;
    }
    CGFloat imageHeight = self.size.height;
    CGFloat scale = width / imageWidth;
    imageHeight = imageHeight * scale;
    
    CGSize scaleSize = CGSizeMake(width, imageHeight);
    UIGraphicsBeginImageContextWithOptions(scaleSize, NO, [UIScreen mainScreen].scale);
    
    [self drawInRect:CGRectMake(0, 0, width, imageHeight)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (CGSize )bc_adaptSize:(CGSize)originSize minSize:(CGSize)imageMinSize maxSize:(CGSize)imageMaxSiz{
    CGSize size;
    NSInteger imageWidth = originSize.width ,imageHeight = originSize.height;
    NSInteger imageMinWidth = imageMinSize.width, imageMinHeight = imageMinSize.height;
    NSInteger imageMaxWidth = imageMaxSiz.width,  imageMaxHeight = imageMaxSiz.height;
    if (imageWidth > imageHeight){
        //宽图
        size.height = imageMinHeight;  //高度取最小高度
        size.width = imageWidth * imageMinHeight / imageHeight;
        if (size.width > imageMaxWidth){
            size.width = imageMaxWidth;
        }
    }
    else if(imageWidth < imageHeight){
        //高图
        size.width = imageMinWidth;
        size.height = imageHeight *imageMinWidth / imageWidth;
        if (size.height > imageMaxHeight){
            size.height = imageMaxHeight;
        }
    }
    else{
        //方图
        if (imageWidth > imageMaxWidth){
            size.width = imageMaxWidth;
            size.height = imageMaxHeight;
        }
        else if(imageWidth > imageMinWidth){
            size.width = imageWidth;
            size.height = imageHeight;
        }
        else{
            size.width = imageMinWidth;
            size.height = imageMinHeight;
        }
    }
    return size;
}

+ (UIImage *)bc_compressionImg:(UIImage *)img toSizeKB:(CGFloat )sizeKB
{
    UIImage *image = img;
    UIImage *destImg = image;
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    CGFloat imgOriginSize = [imgData length]/1024.0;
    if (imgOriginSize > sizeKB) {
        CGFloat imgRatio = ceil(((double)imgOriginSize)/sizeKB);
        if (imgRatio<1) {
            imgRatio = 1;
        }
        CGSize newSize = CGSizeMake(image.size.width/imgRatio, image.size.height/imgRatio);
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        destImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return destImg;
}


+ (NSData *)bc_compressionData:(UIImage *)image toSizeKB:(CGFloat )sizeKB
{
    CGFloat compression = 1.0;
    CGFloat maxLength = sizeKB * 1024;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) {
        return data;
    }
    CGFloat kMax = 1;
    CGFloat kMin = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (kMax + kMin) / 2.0;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            kMin = compression;
        } else if (data.length > maxLength) {
            kMax = compression;
        } else {
            break;
        }
    }
    return data;
}

///MARK: - 裁剪图片
- (UIImage *)bc_cutImg:(CGRect)rect
{
    CGFloat scale = [UIScreen mainScreen].scale;//把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat x = rect.origin.x*scale;
    CGFloat y = rect.origin.y*scale;
    CGFloat w = rect.size.width*scale;
    CGFloat h = rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    CGImageRef sourceImageRef = [self CGImage];//截取部分图片并生成新图片
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}


///MARK: - 水印
+ (UIImage *)bc_addAlpha:(UIImage*)image alpha:(CGFloat )alpha
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(UIImage *)bc_imageChangeTintColor:(UIColor*)color {
    //默认白色
    if (!color) {
        color = UIColor.whiteColor;
    }
    //获取画布
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    //画笔沾取颜色
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //绘制一次
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    //再绘制一次
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/////MARK: - 创建图片
//+ (UIImage *)bc_navigationImageName:(NSString *)imageName
//{
//    return  [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//}

///MARK: - 颜色 -> 图片
+ (UIImage*)bc_imageWithColor:(UIColor *)color {
    return [UIImage bc_imageWithColor:color withSize:CGSizeZero];
}

+ (UIImage*)bc_imageWithColor:(UIColor *)color withSize:(CGSize )imgSize {
    return [UIImage bc_imageWithColor:color withSize:imgSize withDrawBlock:nil];
}

+ (UIImage*)bc_imageWithColor:(UIColor* )color withSize:(CGSize )imgSize withDrawBlock:(void(^_Nullable)(CGSize imgSize) )drawBlock {
    //如果传的size是{0,0}
    if (CGSizeEqualToSize(CGSizeZero, imgSize)) {
        imgSize.width = 1.0f;
        imgSize.height = 1.0f;
    }
    if (!color) {
        color = UIColor.whiteColor;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, imgSize.width, imgSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    if (drawBlock) {
        drawBlock(imgSize);
    }
    UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


///MARK: - 修正图片转向
+ (UIImage *)bc_fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)bc_imageWithOriginal:(NSString *)imgName {
    return  [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage*)bc_imageWithRoundedCornerRadius:(CGFloat)radius renderColor:(UIColor *)color renderSize:(CGSize)size borderWidth:(CGFloat)borderWidth borderCorlor:(UIColor * _Nullable)borderColor {
    
    CGFloat halfBorderWidth = 0;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (borderColor != nil && borderWidth>0) {
        CGContextSetLineWidth(context, borderWidth);
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        halfBorderWidth = borderWidth / 2.0;
    }
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGFloat width = size.width, height = size.height;
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth); // 准备开始移动坐标
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius);
    if (borderWidth > 0) {
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    }else {
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFill);
    }
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)bc_imageWithBcakgroundColor:(UIColor *)color addText:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor space:(NSInteger)space cornerRadius:(NSInteger)radius maxHeight:(NSInteger)height {
    CGSize size = CGSizeMake(10, 10);
    if (text.length > 0) {
        CGFloat textWidth = [text sizeWithAttributes: @{NSFontAttributeName: font}].width;
        size = CGSizeMake(textWidth+space, height);
    }
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    UIImage *bgImage = [self bc_imageWithRoundedCornerRadius:radius renderColor:color renderSize:size borderWidth:0 borderCorlor:[UIColor clearColor]];
    [bgImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    if (text != nil && font != nil && textColor != nil) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{ NSFontAttributeName: font,
                                      NSForegroundColorAttributeName : textColor,
                                      NSParagraphStyleAttributeName : paragraph};
        [text drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
    }
    UIImage* resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

+ (UIImage *)bc_imageWithBackgroundColor:(UIColor *)color addText:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor space:(NSInteger )space cornerRadius:(NSInteger )radius withSize:(CGSize )size {
    if (text.length<=0) {
        return nil;
    }
    //计算 text的 size
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName : textColor,
                                  NSParagraphStyleAttributeName : paragraph};
    
    CGSize textSize = [text sizeWithAttributes:attributes];
    
    //开始准备画布
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    UIImage *bgImage = [self bc_imageWithRoundedCornerRadius:radius renderColor:color renderSize:size borderWidth:0 borderCorlor:[UIColor clearColor]];
    [bgImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //画文字
    CGRect textRect = CGRectMake(floorf((size.width - textSize.width) / 2),
                                 floorf((size.height - textSize.height) / 2),
                                 textSize.width,
                                 textSize.height);
    [text drawInRect:textRect withAttributes:attributes];
    UIImage* resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

///MARK: - view to image
+ (UIImage*)bc_snapshotImageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

///MARK: - layer to image
+ (UIImage *)bc_imageWithLayer:(CALayer *) layer {
    if (!layer) {
        return nil;
    }
    UIGraphicsBeginImageContext(layer.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

///MARK: - 图片旋转
- (UIImage *)bc_imageRotateWithIndegree:(CGFloat)indegree {
    // 1. image --> context
    size_t width = (size_t)(self.size.width * self.scale);
    size_t height = (size_t)(self.size.height * self.scale);

    size_t bytesPerRow = width * 4;                           // 每行图片字节数
    CGImageAlphaInfo alphaInfo = kCGImageAlphaPremultipliedFirst;         // alpha

    // 配置上下文
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrderDefault | alphaInfo);

    if (!bmContext) {
        return nil;
    }

    CGContextDrawImage(bmContext, CGRectMake(0, 0, width, height), self.CGImage);

    // 2. 旋转
    UInt8 *data = (UInt8 *)CGBitmapContextGetData(bmContext);

    // 需要引入 #import <Accelerate/Accelerate.h>  解释这个类干什么用的
    vImage_Buffer src = { data, height, width, bytesPerRow };
    vImage_Buffer dest = { data, height, width, bytesPerRow };
    Pixel_8888 bgColor = { 0, 0, 0, 0 };
    vImageRotate_ARGB8888(&src, &dest, NULL, indegree, bgColor, kvImageBackgroundColorFill);

    // 3. context --> UIImage
    CGImageRef rotateImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *rotateImage = [UIImage imageWithCGImage:rotateImageRef scale:self.scale orientation:self.imageOrientation];

    CGContextRelease(bmContext);
    CGImageRelease(rotateImageRef);

    return rotateImage;
}

///MARK: - 二维码

+ (UIImage *)bc_qrImageWithString:(NSString *)string size:(CGSize)size {
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    // 1. 创建CIFilter对象,设置相关属性
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜默认设置
    [qrFilter setDefaults];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 2. 根据CIFilter对象生成CIImage
    CIImage *qrImage = qrFilter.outputImage;
    // 3. 放大并绘制二维码 (上面生成的二维码很小，需要放大)
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    // 4.翻转一下图片 不然生成的QRCode就是上下颠倒的
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
}

///MARK: - 圆角
- (UIImage *)bc_imageWithCornerRadius:(CGFloat )radius {
    if (!self.size.width || !self.size.height) {
        return nil;
    }

    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGRect rect = (CGRect){0.f,0.f,self.size};
    
    //在当前位图上下文添加圆角绘制路径
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    //当前绘制路径和原绘制路径相交得到最终裁剪绘制路径
    CGContextClip(UIGraphicsGetCurrentContext());

    [self drawInRect:rect];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
