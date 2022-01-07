//
//  UIScrollView+BCHelper.m
//  BCUIKit
//
//  Created by Basic on 2019/4/1.
//

#import "UIScrollView+BCHelper.h"
#import "BCSwizzle.h"

@implementation UIScrollView (BCHelper)
+(void)load {
//    BCSwizzleInstanceMethod([UIScrollView class], BCHookSelector(@"hitTest:withEvent:"), BCSWReturnType(UIView *), BCSWArguments(CGPoint point,UIEvent *event), BCSWReplacement({
//        UIView *touchView = BCSWCallOriginal(point, event);
//        [selfObj bc_hitTest:point withEvent:event withTouchView:touchView];
//        return touchView;
//    }));
}

//MARK: - system
-(NSArray<Class> *)bc_priorityCLSs {
    return objc_getAssociatedObject(self, @selector(bc_priorityCLSs));
}
-(void)setBc_priorityCLSs:(NSArray<Class> *)bc_priorityCLSs {
    objc_setAssociatedObject(self, @selector(bc_priorityCLSs), bc_priorityCLSs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//MARK: - touch event
-(UIView *)bc_hitTest:(CGPoint)point withEvent:(UIEvent *)event withTouchView:(UIView *)touchView
{
    NSArray<Class> *priorityCLSs = self.bc_priorityCLSs;
    if (priorityCLSs.count<=0) {
        return nil;
    }
    BOOL findCls = NO;
    for (Class cls in priorityCLSs) {
        if ([touchView isKindOfClass:cls]) {
            //匹配到优先响应事件的class
            findCls = YES;
            break;
        }
    }
    self.scrollEnabled = !findCls;
    return nil;
}
@end
