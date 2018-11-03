//
//  GXCircleImageController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/22.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXCircleImageController.h"

@interface GXCircleImageController ()
/** 图片 */
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation GXCircleImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 第一种方法
    self.imageView.layer.cornerRadius = 120;
    self.imageView.layer.masksToBounds = YES;

    /*
    // 第二种方法, 比第一种方法快
    // 创建一个透明的上下文
    // NO:代表透明
    UIGraphicsBeginImageContextWithOptions(self.imageView.frame.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctf = UIGraphicsGetCurrentContext();
    
    //添加一个圆圈
    CGRect rect = CGRectMake(0, 0, 240, 240);
    CGContextAddEllipseInRect(ctf, rect);
    
    // 裁剪
    CGContextClip(ctf);
    
    // 把图片画上去
    UIImage *circleImage = [UIImage imageNamed:@"image.jpeg"];
    [circleImage drawInRect:rect];
    
    // 获取图片
    UIImage *iamge = UIGraphicsGetImageFromCurrentImageContext();
    
    self.imageView.image = iamge;
    // 关闭上下文
    UIGraphicsEndImageContext();
     */
}

- (void)circleImage
{
    
}

@end
