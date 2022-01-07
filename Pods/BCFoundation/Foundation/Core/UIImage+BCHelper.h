//
//  UIImage+BCHelper.h
//  Pod
//
//  Created by Basic on 2016/11/17.
//  Copyright © 2016年 naruto. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BCHelper)

///MARK: - 缩放到制定大小

- (UIImage *)bc_scaleFitToSize:(CGSize)size;
- (UIImage *)bc_scaleFillToSize:(CGSize)size;
- (UIImage *)bc_scaleWithMaxWidth:(CGFloat)width;

/**
 适配size

 @param originSize 原始size
 @param imageMinSize 最小sbize
 @param imageMaxSiz 最大size
 @return return value description
 */
+ (CGSize )bc_adaptSize:(CGSize)originSize minSize:(CGSize)imageMinSize maxSize:(CGSize)imageMaxSiz;

/**
 压缩图片到指定大小 kb

 @param img 原图
 @param sizeKB  指定大小kn
 @return return value description
 */
+ (UIImage *)bc_compressionImg:(UIImage *)img toSizeKB:(CGFloat )sizeKB;
+ (NSData *)bc_compressionData:(UIImage *)img toSizeKB:(CGFloat )sizeKB;

///MARK: - 裁剪图片

/**
 裁剪图片

 @param rect rect description
 @return return value description
 */
- (UIImage *)bc_cutImg:(CGRect)rect;

/**
 添加透明度，生成一张新的image

 @param image image description
 @param alpha alpha description
 @return return value description
 */
+ (UIImage *)bc_addAlpha:(UIImage*)image alpha:(CGFloat )alpha;

///MARK: - 创建图片

/**
 根据颜色创建图片，默认大小是{1，1}

 @param color 颜色，默认白色
 @return return value description
 */
+ (UIImage*)bc_imageWithColor:(UIColor *_Nullable)color;

/**
 根据颜色创建图片

 @param color 底色，默认白色
 @param imgSize 图片大小，如果是{0,0}，则默认创建{1,1}大小
 @return return value description
 */
+ (UIImage *)bc_imageWithColor:(UIColor *_Nullable)color withSize:(CGSize )imgSize;


/**
 修改图片的颜色

 @param color 需要改变的颜色，默认白色
 @return return value description
 */
-(UIImage *)bc_imageChangeTintColor:(UIColor*_Nullable)color;

/**
 根据颜色创建图片，可以追加draw block

 @param color 底色
 @param imgSize 图片大小，如果是{0,0}，则默认创建{1,1}大小
 @param drawBlock 追加的draw block
 @return return value description
 */
+ (UIImage *)bc_imageWithColor:(UIColor*_Nullable)color withSize:(CGSize )imgSize withDrawBlock:(void(^_Nullable)(CGSize imgSize) )drawBlock;

///MARK: - 修正图片转向
+ (UIImage *)bc_fixOrientation:(UIImage *)aImage;
///MARK: - 显示原始图片
+ (UIImage *)bc_imageWithOriginal:(NSString *)imgName;

///MARK: -图片+文字

/**
 生成圆角边框图片

 @param radius 圆角
 @param color 填充颜色
 @param size 图片尺寸
 @param borderWidth 边框宽度，大于0，才会绘制边框
 @param borderColor 边框颜色，不为nil，才会绘制边框
 @return image
 */
+ (UIImage*)bc_imageWithRoundedCornerRadius:(CGFloat)radius renderColor:(UIColor *)color renderSize:(CGSize)size borderWidth:(CGFloat)borderWidth borderCorlor:(UIColor *_Nullable)borderColor;


/**
 生成带文字的圆角图片，宽度为文字的宽度+space，高度可以指定

 @param color 背景颜色
 @param text 文本，不为nil，才会绘制文本
 @param font 文本尺寸，不为nil，才会绘制文本
 @param textColor 文本颜色，不为nil，才会绘制文本
 @param space 图片文本间距
 @param radius 圆角角度
 @param height 图片高度
 @return image
 */
+ (UIImage *)bc_imageWithBcakgroundColor:(UIColor *)color addText:(NSString  *_Nullable)text textFont:(UIFont *_Nullable)font textColor:(UIColor *_Nullable)textColor space:(NSInteger )space cornerRadius:(NSInteger )radius maxHeight:(NSInteger )height;


/**
 生成带文字的圆角图片，指定图片size，文字居中

 @param color color description
 @param text text description
 @param font font description
 @param textColor textColor description
 @param space space description
 @param radius radius description
 @param size size description
 @return return value description
 */
+ (UIImage *)bc_imageWithBackgroundColor:(UIColor *)color addText:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)textColor space:(NSInteger )space cornerRadius:(NSInteger )radius withSize:(CGSize )size;

///MARK: - view to image
///  截取view屏幕
/// @param view view description
+ (UIImage*)bc_snapshotImageFromView:(UIView *)view;

///MARK: - layer to image
///  layer 生成image
/// @param layer layer description
+ (UIImage *)bc_imageWithLayer:(CALayer *) layer;

///MARK: - 图片旋转

/// 图片旋转
/// @param indegree 角度
- (UIImage *)bc_imageRotateWithIndegree:(CGFloat)indegree;


///MARK: - 二维码

/// 生成二维码图片
/// @param string string description
/// @param size size description
+ (UIImage *)bc_qrImageWithString:(NSString *)string size:(CGSize)size;

///MARK: - 圆角

/// 切割图片圆角
/// @param radius 圆角半径
- (UIImage *)bc_imageWithCornerRadius:(CGFloat )radius;

@end


NS_ASSUME_NONNULL_END
