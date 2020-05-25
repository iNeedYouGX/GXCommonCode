//
//  GXElementLabel.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/13.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXElementLabel.h"

@implementation GXElementLabel
+ (instancetype)elementLabelMainTitle:(NSString *)Title
{
    GXElementLabel *label = [[GXElementLabel alloc] init];
    label.text = Title;
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 17];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.layer.shadowColor = UIColorFromRGB(0x70A9E3).CGColor;
    label.layer.shadowOpacity = 1;
    label.x = 10;
    label.width = SCR_WIDTH - 20;
    CGSize size = [label sizeThatFits:CGSizeMake(label.width, 10)];
    label.height = size.height;
    return label;
}

+ (void)elementLabelMainTitle:(NSString *)title containView:(UIView *)containView
{
    GXElementLabel *mainLabel = [GXElementLabel elementLabelMainTitle:title];
    mainLabel.y = CZGetY([containView.subviews lastObject]) + 10;
    [containView addSubview:mainLabel];
}
@end
