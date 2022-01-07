//
//  UINavigationItem+BCHelper.m
//  Pods
//
//  Created by Basic on 2017/8/4.
//
//

#import "UINavigationItem+BCHelper.h"
#import "UIBarButtonItem+BCHelper.h"
#import <BCComConfigKit/BCComConfigKit.h>

@implementation UINavigationItem (BCHelper)

#pragma mark - title
- (void)bc_setTitle:(NSString *)title {
    self.title = title;
}

- (void)bc_setSubTitle:(NSString *)title {
    self.title = [NSString stringWithFormat:@"%@\n%@",self.title,title];
}
- (void)bc_setupTitleLeftSpace {
    UIBarButtonItem *paddingItem = (self.leftBarButtonItem)?:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 20.0;
    self.leftBarButtonItems = @[paddingItem,fixedSpace];
}
#pragma mark - 设置left item
-(void)bc_setLeftItem:(UIView *)view {
    if (!view) {
        [self setLeftBarButtonItem:nil];
        return;
    }
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    [self setLeftBarButtonItem:leftItem];
}
-(void)bc_setBackItem:(void(^)(UIButton *sender) )action {
    [self bc_setLeftItemImg:BCComConfig.config.navBackImg withText:nil withRedDot:false withAction:action];
}
-(void)bc_setLeftRedDotItem:(UIImage *)img action:(void (^)(UIButton * _Nonnull))action {
    [self bc_setLeftItemImg:img withText:nil withRedDot:true withAction:action];
}
-(void)bc_setLeftItemText:(NSString *)text action:(void(^)(UIButton *sender) )action {
    [self bc_setLeftItemImg:nil withText:text withRedDot:false withAction:action];
}
-(void)bc_setLeftItemImg:(UIImage *)img action:(void(^)(UIButton *sender) )action {
    [self bc_setLeftItemImg:img withText:nil withRedDot:false withAction:action];
}
-(void)bc_setLeftItemImg:(UIImage *)img text:(NSString *)text action:(void(^)(UIButton *sender) )action {
    [self bc_setLeftItemImg:img withText:text withRedDot:false withAction:action];
}
-(void)bc_setLeftItemImg:(UIImage *)img withText:(NSString *)text withRedDot:(BOOL)showRedDot withAction:(void(^)(UIButton *sender) )action {
    if(text.length<=0 && !img){
        return;
    }
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] bc_initLeftItem:img withHighlightImage:nil withText:text withTextColor:nil withRedDot:showRedDot withAction:action];
    self.leftBarButtonItem = leftItem;
}

#pragma mark - 设置right item
-(void)bc_setRightItem:(UIView *)view {
    if (!view) {
        [self setRightBarButtonItem:nil];
        return;
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    [self setRightBarButtonItem:rightItem];
}
-(void)bc_setRightItemText:(NSString *)text action:(void(^)(UIButton *sender) )action {
    if(text.length<=0) { return; }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:text image:nil action:action];
    [barItem bc_updateTextColor:nil highlightColor:nil disableTextColor:nil];
    [self setRightBarButtonItem:barItem];
}
- (void)bc_setRightItemText:(NSString *)text construction:(void (^)(UIBarButtonItem * _Nonnull))construction action:(void (^)(UIButton * _Nonnull))action {
    if(text.length<=0) { return; }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:text image:nil action:action];
    [barItem bc_updateTextColor:nil highlightColor:nil disableTextColor:nil];
    if (construction) {
        construction(barItem);
    }
    [self setRightBarButtonItem:barItem];
}
-(void)bc_setRightItemImg:(UIImage *)img text:(NSString *)text textColor:(UIColor *)textColor action:(void (^)(UIButton * _Nonnull))action {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:text image:img action:action];
    [barItem bc_updateTextColor:textColor highlightColor:nil disableTextColor:nil];
    [barItem bc_updateImage:img highlightImage:nil disableImage:nil];
    [self setRightBarButtonItem:barItem];
}
-(void)bc_setRightItemImg:(UIImage *)img action:(void(^)(UIButton *sender) )action {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:nil image:img action:action];
    [barItem bc_updateTextColor:nil highlightColor:nil disableTextColor:nil];
    [barItem bc_updateImage:img highlightImage:nil disableImage:nil];
    [self setRightBarButtonItem:barItem];
}
-(void)bc_setRightItemImg:(UIImage *)img withDisableImg:(UIImage *)disableImg withAction:(void (^)(UIButton * _Nonnull))action {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:nil image:img action:action];
    [barItem bc_updateTextColor:nil highlightColor:nil disableTextColor:nil];
    [barItem bc_updateImage:img highlightImage:nil disableImage:disableImg];
    [self setRightBarButtonItem:barItem];
}
-(void)bc_setRightItemImg:(UIImage *)img text:(NSString *)text action:(void(^)(UIButton *sender) )action {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:text image:img action:action];
    [barItem bc_updateTextColor:nil highlightColor:nil disableTextColor:nil];
    [barItem bc_updateImage:img highlightImage:nil disableImage:nil];
    [self setRightBarButtonItem:barItem];
}
-(void)bc_setRightItemImg:(UIImage *)img withDisableImg:(UIImage *_Nullable)disableImg text:(NSString *)text textColor:(UIColor *)textColor action:(void(^)(UIButton *sender) )action {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:text image:img action:action];
    [barItem bc_updateTextColor:textColor highlightColor:nil disableTextColor:nil];
    [barItem bc_updateImage:img highlightImage:nil disableImage:disableImg];
    [self setRightBarButtonItem:barItem];
}

-(void)bc_addRightItemImg:(UIImage *)img action:(void(^)(UIButton *sender) )action {
    [self bc_addRightItemImg:img construction:nil action:action];
}
-(void)bc_addRightItemImg:(UIImage *)img construction:(void (^)(UIBarButtonItem * _Nonnull))construction action:(void(^)(UIButton *sender) )action {
    NSArray *rightItemOriginals = self.rightBarButtonItems;
    NSMutableArray *listItems = [[NSMutableArray alloc] initWithArray:rightItemOriginals];
    if([[UIDevice currentDevice].systemVersion floatValue]<11.0){
        UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        rightSpace.width = 20;
        [listItems addObject:rightSpace];
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] bc_initWithButton:nil image:img action:action];
    [barItem bc_updateTextColor:nil highlightColor:nil disableTextColor:nil];
    [barItem bc_updateImage:img highlightImage:nil disableImage:nil];
    [listItems addObject:barItem];
    if (construction) {
        construction(barItem);
    }
    [self setRightBarButtonItems:listItems];
}
-(void)bc_updateRightItemText:(NSString *)text {
    if(text.length<=0){
        return;
    }
    UIBarButtonItem *rightItem = self.rightBarButtonItem;
    if(![rightItem.customView isKindOfClass:[UIButton class]]){
        return;
    }
    UIButton *rightBtn = (UIButton *)rightItem.customView;
    [rightBtn setTitle:text forState:UIControlStateNormal];
    [rightBtn sizeToFit];
}
@end
