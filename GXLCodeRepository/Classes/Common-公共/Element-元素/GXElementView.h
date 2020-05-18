//
//  GXElementView.h
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/13.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXElementView : UIView
+ (instancetype)elementViewTitle:(NSString *)Title;
+ (instancetype)elementViewImage:(NSString *)imageUrl;
@end

NS_ASSUME_NONNULL_END
