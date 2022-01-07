//
//  UIButton+BCHelper.m
//  Pod
//
//  Created by Basic on 2016/11/17.
//  Copyright © 2016年 naruto. All rights reserved.
//

#import "UIButton+BCHelper.h"
#import <BCFoundation/NSString+BCHelper.h>
#import <BCFoundation/BCSwizzle.h>
#import <objc/runtime.h>

static char *actionBlockKey;

@implementation UIButton (BCHelper)
#pragma mark - system
+(void)load
{
    BCSwizzleInstanceMethod([UIButton class], @selector(pointInside:withEvent:), BCSWReturnType(BOOL), BCSWArguments(CGPoint point ,UIEvent *event), BCSWReplacement({
        UIButton *selfBtn = (UIButton *)selfObj;
        //先判断是否禁用圆角响应事件
        if (selfBtn.bc_disableCornerEvent && selfBtn.layer.cornerRadius>0 && (selfBtn.clipsToBounds || selfBtn.layer.masksToBounds)) {
            //先调用系统判断是否在按钮内部
            BOOL originValue = BCSWCallOriginal(point,event);
            if (originValue) {
                UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:selfBtn.bounds];
                if ([path containsPoint:point]) {
                    //圆角内
                    return YES;
                } else {
                    //圆角外，frame 内
                    return NO;
                }
            }
            return originValue;
        }
        //如果未设置扩展点击范围，调用系统
        if(UIEdgeInsetsEqualToEdgeInsets(selfBtn.bc_hitTestEdgeInsets, UIEdgeInsetsZero) || !selfBtn.enabled || selfBtn.hidden) {
            return BCSWCallOriginal(point,event);
        }
        CGRect relativeFrame = selfBtn.bounds;
        CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, selfBtn.bc_hitTestEdgeInsets);
        return CGRectContainsPoint(hitFrame, point);
    }));
}

+ (instancetype)bc_allocButton:(void(^)(UIButton *btn))configureBlock action:(void(^)(UIButton *btn))actionBlock
{
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (configureBlock) {
        configureBlock(btn);
    }
    [btn bc_addTouchUpInsideEvent:actionBlock];
    return btn;
}

#pragma mark - 添加 TouchUpInside 事件
-(void)bc_addTouchUpInsideEvent:(void(^)(UIButton *btn))actionBlock
{
    objc_setAssociatedObject(self, &actionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionCallBlock:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button Event
- (void)actionCallBlock:(UIButton *)btn
{
    void (^actionBlock) (UIButton *btn) = objc_getAssociatedObject(self, &actionBlockKey);
    if (actionBlock) {
        actionBlock(btn);
    }
}

#pragma mark - bc_contentTop
-(NSInteger)bc_contentTop
{
    return [objc_getAssociatedObject(self, @selector(bc_contentTop)) integerValue];
}

-(void)setBc_contentTop:(NSInteger)bc_contentTop
{
    objc_setAssociatedObject(self, @selector(bc_contentTop), @(bc_contentTop), OBJC_ASSOCIATION_ASSIGN);
}

-(NSInteger)bc_contentSpace
{
    return [objc_getAssociatedObject(self, @selector(bc_contentSpace)) integerValue];
}

-(void)setBc_contentSpace:(NSInteger )bc_contentSpace
{
    objc_setAssociatedObject(self, @selector(bc_contentSpace), @(bc_contentSpace), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Tag
-(NSInteger )bc_numTag {
    return [objc_getAssociatedObject(self, @selector(bc_numTag)) integerValue];
}

-(void)setBc_numTag:(NSInteger)bc_numTag {
    objc_setAssociatedObject(self, @selector(bc_numTag), @(bc_numTag), OBJC_ASSOCIATION_ASSIGN);
}

-(NSString *)bc_strTag {
    return objc_getAssociatedObject(self, @selector(bc_strTag));
}
-(void)setBc_strTag:(NSString *)bc_strTag {
    objc_setAssociatedObject(self, @selector(bc_strTag), bc_strTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(id)bc_extData {
    return objc_getAssociatedObject(self, @selector(bc_extData));
}
-(void)setBc_extData:(id)bc_extData {
    objc_setAssociatedObject(self, @selector(bc_extData), bc_extData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 是否禁用圆角响应事件
-(BOOL)bc_disableCornerEvent {
    return [objc_getAssociatedObject(self, @selector(bc_disableCornerEvent)) boolValue];
}
-(void)setBc_disableCornerEvent:(BOOL)bc_disableCornerEvent {
    objc_setAssociatedObject(self, @selector(bc_disableCornerEvent), @(bc_disableCornerEvent), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - 刷新 image 、title
- (void)bc_layoutImageTile
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [NSString bc_autoSize:self.titleLabel.text font:self.titleLabel.font] ;
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat titleTop =  0-titleSize.height + self.bc_contentTop;
    CGFloat titleBottom = 0- imageSize.height - self.bc_contentTop - self.bc_contentSpace;
    self.imageEdgeInsets = UIEdgeInsetsMake(titleTop, 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, titleBottom, 0);
}

- (void)bc_layoutImageTile:(int )style withSpace:(CGFloat)space
{
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case kUIButtonEdgeInsetsStyle_Top:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case kUIButtonEdgeInsetsStyle_Left:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case kUIButtonEdgeInsetsStyle_Bottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case kUIButtonEdgeInsetsStyle_Right:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

- (void)bc_addClickInterval:(CGFloat)interval {
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enabled = YES;
    });
}
#pragma mark - Extensions
-(UIEdgeInsets)bc_hitTestEdgeInsets
{
    NSValue *value = objc_getAssociatedObject(self, @selector(bc_hitTestEdgeInsets));
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

-(void)setBc_hitTestEdgeInsets:(UIEdgeInsets)bc_hitTestEdgeInsets
{
    NSValue *value = [NSValue value:&bc_hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(bc_hitTestEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
