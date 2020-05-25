//
//  GXOutputImageController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/11.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXOutputImageController.h"
#import "GXSaveImageToPhone.h"

@interface GXOutputImageController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** <#注释#> */
@property (nonatomic, strong) UIView *theView;

@end

@implementation GXOutputImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.theView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, SCR_WIDTH - 20, 44)];
    self.theView.layer.cornerRadius = 10;
    self.theView.layer.masksToBounds = YES;
    [self.view addSubview:self.theView];
    
}

#pragma mark - 根据颜色输出图片
- (IBAction)outputImage:(UIButton *)sender {
    
    
    /**创建一个CAGradientLayer 对象*/
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    /**设置gradientLayer 的 Frame*/
    gradientLayer.frame = self.theView.bounds;
    
    
    /**
     颜色数组，默认为nil,该数组定义了每一个渐变值得颜色。
     这个数组成员接受CGColorRef类型的值,如果你愿意，colors属性可以包含很多颜色，所以创建一个彩虹一样的多重渐变也是很简单的。
     默认情况下，这些颜色在空间上均匀地被渲染，但是我们可以用locations属性来调整空间。
     */
    gradientLayer.colors = @[
        (__bridge id)UIColorFromRGB(0xD799A3).CGColor,
        (__bridge id)UIColorFromRGB(0xE31436).CGColor,
        //        (__bridge id)[UIColor blueColor].CGColor
    ];
    
    /**
     渐变位置(即定义了colors属性中每个不同颜色的位置)，范围在[0,1],数组中的值必须是渐变增加，如果数组为nil，那么将均匀渐变，当渲染的时候，颜色数组值会被映射到输出颜色空间。
     */
    gradientLayer.locations = @[@(0.0f) ,@(1.0f)];
    
    
    /**
     startPoint和endPoint属性，它们决定了渐变的方向。
     startPoint就是第一个渐变点，endPoint就是最后一个渐变点。
     这两个参数是以单位坐标系进行的定义，当进行绘制内容的时候会映射到layer的矩形区域，
     左上角坐标是[0,0]，右下角坐标是[1,1]。默认值是[.5,0]和[.5,1]。
     */
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    /**添加渐变色到创建的 UIView 上去*/
    [self.theView.layer addSublayer:gradientLayer];
    
    
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.opaque, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageView.image = outputImage;;
    
//    NSData *data = UIImagePNGRepresentation(outputImage);
//
//    [data writeToFile:@"/Users/lgx/Desktop/image.png" atomically:YES];
}

// 分享
- (IBAction)shareImage:(UIButton *)sender
{
    [GXSaveImageToPhone saveBatchImage:self.imageView.image];
}


#pragma mark - 我也看不明白

- (UIImage *)drawCircleImage:(UIImage *)image {
    
    CGFloat side = MIN(image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), false, [UIScreen mainScreen].scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, side, side)].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    CGFloat marginX = -(image.size.width - side) / 2.f;
    
    CGFloat marginY = -(image.size.height - side) / 2.f;
    
    [image drawInRect:CGRectMake(marginX, marginY, image.size.width, image.size.height)];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}


#pragma mark - 颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
