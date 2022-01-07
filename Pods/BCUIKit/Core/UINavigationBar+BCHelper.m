//
//  UINavigationBar+BCHelper.m
//  Pod
//
//  Created by Basic on 15/6/2.
//  Copyright (c) 2015年 Basic. All rights reserved.
//

#import "UINavigationBar+BCHelper.h"
#import <BCFoundation/BCFoundationUtils.h>
#import <BCFoundation/UIColor+BCHelper.h>
#import <BCFoundation/UIImage+BCHelper.h>
#import "BCComConfigKit/BCComConfigKit.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BCHelper)

#pragma mark - 自定义navigationBar
- (UIView *)bc_navigationBar
{
    return objc_getAssociatedObject(self, @selector(bc_navigationBar));
}
- (void)setBc_navigationBar:(UIView *)bc_navigationBar
{
    objc_setAssociatedObject(self,@selector(bc_navigationBar), bc_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)bc_setBackgroundColor:(UIColor *)backgroundColor
{
    if (UINavigationBar.hh_useSystem) {
        //使用系统默认实现
        if (!backgroundColor) {
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            return;
        }
        [self setBackgroundImage:[UIImage bc_imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
    } else {
        //自定义实现，添加一个UIView
        if (!backgroundColor) {
            self.bc_navigationBar.hidden = YES;
            return;
        }
        UIView *navigationBarView = self.bc_navigationBar;
        if (!navigationBarView) {
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kBCNAVBAR_HEIGHT)];
            navigationBarView.userInteractionEnabled = NO;
            navigationBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.bc_navigationBar = navigationBarView;
        }
        //添加到系统导航栏
        if (navigationBarView && !navigationBarView.superview) {
            [[self.subviews firstObject] insertSubview:navigationBarView atIndex:0];
        }
        //更改颜色
        if(!CGColorEqualToColor(self.bc_navigationBar.backgroundColor.CGColor,backgroundColor.CGColor)){
            self.bc_navigationBar.backgroundColor = backgroundColor;
        }
    }
}


#pragma mark - 自定义分割线
- (UIView *)bc_navigationSplitLine
{
    return objc_getAssociatedObject(self, @selector(bc_navigationSplitLine));
}
- (void)setBc_navigationSplitLine:(UIView *)bc_navigationSplitLine
{
    objc_setAssociatedObject(self,@selector(bc_navigationSplitLine), bc_navigationSplitLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)bc_splitColor
{
    return self.bc_navigationSplitLine.backgroundColor;
}
- (void)bc_setSplitColor:(UIColor *)splitColor
{
    if (UINavigationBar.hh_useSystem) {
        //使用系统实现
        if (!splitColor) {
            [self setShadowImage:[UIImage new]];
            return;
        }
        UIImage *splitImg = [UIImage bc_imageWithColor:splitColor withSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5f)];
        [self setShadowImage:splitImg];
    } else {
        //使用自定义实现
        if (!splitColor) {
            self.bc_navigationSplitLine.hidden = YES;
            return;
        }
        //添加 分割线view
        if (!self.bc_navigationSplitLine) {
            UIView *splitLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bc_navigationBar.frame)-0.2, CGRectGetWidth(self.bounds), 0.5)];
            splitLineView.userInteractionEnabled = NO;
            [self.bc_navigationBar addSubview:splitLineView];
            self.bc_navigationSplitLine = splitLineView;
        }
        self.bc_navigationSplitLine.backgroundColor = splitColor;
        self.bc_navigationSplitLine.hidden = NO;
        self.bc_navigationSplitLine.alpha = 1;
    }
    
}
- (void)bc_setSplitAlpha:(CGFloat )alpha
{
    self.bc_navigationSplitLine.hidden = (alpha==0);
    self.bc_navigationSplitLine.alpha = alpha;
}



#pragma mark - _hh_useSystem
static BOOL _hh_useSystem = NO;
+(BOOL )hh_useSystem {
    return _hh_useSystem;
}
+(void)setHh_useSystem:(BOOL)hh_useSystem {
    _hh_useSystem = hh_useSystem;
}

#pragma mark - 渐变背景
- (void)bc_showGradientLayer:(UIColor *)startColor withStartPoint:(CGPoint )startPoint withEndColor:(UIColor *)endColor withEndPoint:(CGPoint )endPoint {
    if (!startColor || !endColor) {
        return ;
    }
    CAGradientLayer *bgLayer = [CAGradientLayer layer];
    bgLayer.colors = @[ (__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    bgLayer.startPoint = startPoint;
    bgLayer.endPoint = endPoint;
    CGRect layerFrame = self.bounds;
    layerFrame.size.width = MAX(layerFrame.size.width, kBCSCREEN_WIDTH);
    layerFrame.size.height = MAX(layerFrame.size.height, kBCNAVBAR_HEIGHT);
    bgLayer.frame = layerFrame;
    UIImage *bgLayerImg = [UIImage bc_imageWithLayer:bgLayer];
    if (bgLayerImg) {
        [self setBackgroundImage:bgLayerImg forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - helper
- (void) bc_checkNavBarHasShow {
    UIView *navigationBarView = self.bc_navigationBar;
    //添加到系统导航栏
    if (navigationBarView && !navigationBarView.superview) {
        [[self.subviews firstObject] insertSubview:navigationBarView atIndex:0];
    }
}
@end
