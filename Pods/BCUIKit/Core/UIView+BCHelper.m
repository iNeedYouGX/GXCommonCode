//
//  UIView+BCHelper.m
//  Pod
//
//  Created by Basic on 2016/11/16.
//  Copyright © 2016年 naruto. All rights reserved.
//



#import "UIView+BCHelper.h"
#import <BCFoundation/UIColor+BCHelper.h>
#import <objc/runtime.h>

typedef void (^UIViewZHHelperGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@implementation UIView (BCHelper)
//MARK: - frame
- (CGFloat)bc_height {
    return CGRectGetHeight(self.bounds);
}
- (CGFloat)bc_width {
    return CGRectGetWidth(self.bounds);
}
- (CGFloat)bc_x {
    return self.frame.origin.x;
}
- (void)setBc_x:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setBc_y:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}
- (CGFloat)bc_y {
    return self.frame.origin.y;
}
- (CGSize)bc_size {
    return self.frame.size;
}
- (CGPoint)bc_origin {
    return self.frame.origin;
}
- (void)setBc_origin:(CGPoint )origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGFloat)bc_centerX {
    return self.center.x;
}
- (CGFloat)bc_centerY {
    return self.center.y;
}
- (CGFloat)bc_bottom {
    return self.frame.size.height + self.frame.origin.y;
}
- (void )setBc_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)bc_right {
    return self.frame.size.width + self.frame.origin.x;
}
- (void )setBc_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
// height
- (void)setBc_height:(CGFloat)height {
    CGRect newFrame = CGRectMake(self.bc_x, self.bc_y, self.bc_width, height);
    self.frame = newFrame;
}
- (void)bc_heightEqualToView:(UIView *)view {
    self.bc_height = view.bc_height;
}
// width
- (void)setBc_width:(CGFloat)width {
    CGRect newFrame = CGRectMake(self.bc_x, self.bc_y, width, self.bc_height);
    self.frame = newFrame;
}
- (void)bc_widthEqualToView:(UIView *)view {
    self.bc_width = view.bc_width;
}
// center
- (void)setBc_centerX:(CGFloat)centerX {
    CGPoint center = CGPointMake(self.bc_centerX, self.bc_centerY);
    center.x = centerX;
    self.center = center;
}
- (void)setBc_centerY:(CGFloat)centerY {
    CGPoint center = CGPointMake(self.bc_centerX, self.bc_centerY);
    center.y = centerY;
    self.center = center;
}
// size
- (void)setBc_size:(CGSize)size {
    self.frame = CGRectMake(self.bc_x, self.bc_y, size.width, size.height);
}
- (void)bc_sizeEqualToView:(UIView *)view {
    self.frame = CGRectMake(self.bc_x, self.bc_y, view.bc_width, view.bc_height);
}

//MARK: - Constraint
- (CGFloat )getConstraintValue:(NSLayoutAttribute )attribute {
    CGFloat result = 0;
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        //width height 在当前view的约束里
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstItem == self && constraint.firstAttribute == attribute && constraint.constant > 0) {
                result = constraint.constant;
                break;
            }
        }
    }
    else {
        //其他都在super的约束里
        if (self.superview != nil) {
            for (NSLayoutConstraint *constraint in self.superview.constraints) {
                if (constraint.firstItem == self && constraint.firstAttribute == attribute) {
                    result = constraint.constant;
                    break;
                }
            }
        }
    }
    return result;
}

#pragma mark - 边框圆角
- (void)bc_addBorderTop:(BOOL)top bottom:(BOOL)bottom left:(BOOL)left right:(BOOL)right color:(UIColor *)color {
    if (top) {
        [self bc_addUpperBorder:UIRectEdgeTop color:color thickness:0.5f];
    }
    if (bottom) {
        [self bc_addUpperBorder:UIRectEdgeBottom color:color thickness:0.5f];
    }
    if (left) {
        [self bc_addUpperBorder:UIRectEdgeLeft color:color thickness:0.5f];
    }
    if (right) {
        [self bc_addUpperBorder:UIRectEdgeRight color:color thickness:0.5f];
    }
}
- (void)bc_addUpperBorder:(UIRectEdge)edge color:(UIColor *)color thickness:(CGFloat)thickness {
    CALayer *border = [CALayer layer];
    switch (edge) {
        case UIRectEdgeTop:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), thickness);
            break;
        case UIRectEdgeBottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, CGRectGetWidth(self.frame), thickness);
            break;
        case UIRectEdgeLeft:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame));
            break;
        case UIRectEdgeRight:
            border.frame = CGRectMake(CGRectGetWidth(self.frame)-thickness, 0, thickness, CGRectGetHeight(self.frame));
            break;
        default:
            break;
    }
    border.backgroundColor = color.CGColor;
    [self.layer addSublayer:border];
}
- (void)bc_addCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    if (self.bounds.size.width<0.5 || self.bounds.size.height<0.5) {
        [self layoutIfNeeded];
    }
    self.layer.mask = nil;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


//MARK: - 单击、长按手势
static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;
- (void)bc_addTapActionWithBlock:(void (^)(UIGestureRecognizer *))block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture){
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bc_handleActionForTapGesture:)];
//        gesture.cancelsTouchesInView = NO;
        gesture.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)bc_removeTapGesture {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (gesture){
        [self removeGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, nil, OBJC_ASSOCIATION_RETAIN);
        objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, nil, OBJC_ASSOCIATION_COPY);
    }
}
- (void)bc_handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized){
        UIViewZHHelperGestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block){
            block(gesture);
        }
    }
}
- (void)bc_addLongPressActionWithBlock:(void (^)(UIGestureRecognizer *))block {
    [self bc_addLongPressGesture:0.5 withBlock:block];
}
- (void)bc_addLongPressGesture:(NSInteger)minDuration withBlock:(void (^)(UIGestureRecognizer * _Nonnull))block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture){
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(bc_handleActionForLongPressGesture:)];
        gesture.minimumPressDuration = minDuration;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)bc_handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized){
        UIViewZHHelperGestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block){
            block(gesture);
        }
    }
}
-(void)bc_removeLongPressGesture {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (gesture){
        [self removeGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, nil, OBJC_ASSOCIATION_RETAIN);
        objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, nil, OBJC_ASSOCIATION_COPY);
    }
}


//MARK: - 上次点击 时间
- (NSTimeInterval)bc_lastClickDate {
    return [objc_getAssociatedObject(self, @selector(bc_lastClickDate)) doubleValue];
}
- (void)setBc_lastClickDate:(NSTimeInterval)bc_lastClickDate {
    objc_setAssociatedObject(self, @selector(bc_lastClickDate), @(bc_lastClickDate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//MARK: - 渐变色
- (void)setBc_gradientBgLayer:(CAGradientLayer *)bc_gradientBgLayer {
    objc_setAssociatedObject(self, @selector(bc_gradientBgLayer), bc_gradientBgLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CAGradientLayer *)bc_gradientBgLayer {
    CAGradientLayer *gradientLayer = objc_getAssociatedObject(self, @selector(bc_gradientBgLayer));
    return gradientLayer;
}
- (void)bc_setGradientBgColor:(NSInteger )direction startColor:(nonnull UIColor *)startColor endColor:(nonnull UIColor *)endColor {
    [self bc_setGradientBgColor:direction startColor:startColor endColor:endColor frame:self.bounds];
}
- (void)bc_setGradientBgColor:(NSInteger)direction startColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [self bc_gradientBgLayer];
    if (startColor != nil && endColor != nil) {
        //有渐变色
        if (!gradientLayer) {
            gradientLayer = [CAGradientLayer layer];
            [self setBc_gradientBgLayer:gradientLayer];
            gradientLayer.startPoint = CGPointMake(0, 0);
            if (direction == BCGradientDirectionTopBottom) {
                gradientLayer.endPoint = CGPointMake(0, 1.0);
            } else if (direction == BCGradientDirectionLeftRight){
                gradientLayer.endPoint = CGPointMake(1.0, 0);
            } else {
                gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            }
            [self.layer insertSublayer:gradientLayer atIndex:0];
        }
        gradientLayer.frame = frame;
        gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    }
    else {
        [gradientLayer removeFromSuperlayer];
    }
}

//MARK: - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // UITableViewCellContentView => UITableViewCell
    if([touch.view isKindOfClass:[UITableViewCell class]] || [touch.view.superview isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    else if([touch.view isKindOfClass:[UICollectionViewCell class]] ||
            [touch.view.superview isKindOfClass:[UICollectionViewCell class]] || [touch.view.superview.superview isKindOfClass:[UICollectionView class]]) {
        return NO;
    }
    //YeQing 注释,tableViewCellContentView 嵌套可以点击的imageview,以下判断会导致无法响应
//    // UITableViewCellContentView => UITableViewCellScrollView => UITableViewCell
//    if([touch.view.superview.superview isKindOfClass:[UITableViewCell class]]) {
//        return NO;
//    }
    else if([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}


//MARK: - utils
- (UIView *)bc_firstResponder {
    UIView *firstResponder = nil;
    for (UIView * view in self.subviews) {
        if (view.isFirstResponder) {
            firstResponder = view;
            break;
        } else {
            for (UIView *subView in view.subviews) {
                if (subView.isFirstResponder) {
                    firstResponder = subView;
                    break;
                }
            }
            if (firstResponder) {
                break;
            }
        }
    }
    return firstResponder;
}
- (UIViewController *)bc_viewControllerWithName:(nullable NSString *)clsName {
    if (clsName.length < 1) {
        clsName = @"UIViewController";
    }
    id responder = self;
    while (responder){
        if ([responder isKindOfClass:NSClassFromString(clsName)]){
            return responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}
- (UIView *)bc_subviewWithTag:(NSInteger)tag {
    for (UIView *view in [self subviews]) {
        if(view.tag == tag){
            return view;
        }
    }
    return nil;
}
@end
