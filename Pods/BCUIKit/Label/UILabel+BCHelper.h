//
//  UILabel+BCHelper.h
//  Pod
//
//  Created by Basic on 2016/11/16.
//  Copyright © 2016年 naruto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (BCHelper)

/// UILabel 工厂创建方法
/// @param configureBlock configureBlock description
+ (instancetype)bc_allocLable:(void (^_Nullable)(UILabel* label))configureBlock;


/// 设置行间距
/// @param text text description
/// @param space 间距
- (void)bc_setText:(NSString *)text withLineSpacing:(CGFloat)space;

@end


NS_ASSUME_NONNULL_END
