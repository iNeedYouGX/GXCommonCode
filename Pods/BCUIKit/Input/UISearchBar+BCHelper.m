//
//  UISearchBar+BCHelper.m
//  Pods
//
//  Created by Basic. on 2019/10/11.
//

#import "UISearchBar+BCHelper.h"

@implementation UISearchBar (BCHelper)

- (UITextField *)bc_searchTextField {
        #ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        return self.searchTextField;
    }
        #endif
    return [self valueForKey:@"_searchField"];
}

- (UIView *)bc_backgroundView {
    UIView *backgroundView = nil;
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:@"_UITextFieldImageBackgroundView"]) {
            backgroundView = subView;
            break;
        }
    }
    return backgroundView;
}
@end
 
