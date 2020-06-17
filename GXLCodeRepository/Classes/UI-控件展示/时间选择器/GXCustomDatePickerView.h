//
//  GXCustomDatePickerView.h
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/6/12.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXCustomDatePickerView : UIView
+ (instancetype)customDatePickerViewConfirmAction:(void (^)(NSString *dataStr))confirmBlock cancelAction:(void (^)(void))cancelBlock;
- (void)dismiss;
- (void)show;
@end

NS_ASSUME_NONNULL_END
