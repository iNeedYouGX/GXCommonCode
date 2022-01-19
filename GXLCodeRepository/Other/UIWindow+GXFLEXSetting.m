//
//  UIWindow+GXFLEXSetting.m
//  GXLCodeRepository
//
//  Created by GX on 2022/1/18.
//  Copyright © 2022 JasonBourne. All rights reserved.
//

#import "UIWindow+GXFLEXSetting.h"
#import "FLEXManager.h"

@implementation UIWindow (GXFLEXSetting)
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [super motionBegan:motion withEvent:event];
    
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] showExplorer];

    }
}
@end
