//
//  GXElementView.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/13.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXElementView.h"
#import "GXZoomImageView.h"

@implementation GXElementView
+ (instancetype)elementViewTitle:(NSString *)Title
{
    GXElementView *elementView = [[GXElementView alloc] init];
    elementView.x = 10;
    elementView.width = SCR_WIDTH - 20;
    elementView.backgroundColor = UIColorFromRGB(0x0E0504);
    elementView.layer.shadowOpacity = 1;
    elementView.layer.shadowColor = UIColorFromRGB(0x9E65AE).CGColor;
    elementView.layer.cornerRadius = 7.5;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0x9E65AE);
    label.text = Title;
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 13];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.x = 10;
    label.y = 10;
    label.width = elementView.width - 20;
    label.height = [label sizeThatFits:CGSizeMake(label.width, 10)].height;
    
    elementView.height = label.height + 20;
    [elementView addSubview:label];
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(generalPaste:)];
    [label addGestureRecognizer:tap];
    
    return elementView;
}

/** 复制到剪切板 */
+ (void)generalPaste:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    UIPasteboard *posteboard = [UIPasteboard generalPasteboard];
    posteboard.string = label.text;
    [CZProgressHUD showProgressHUDWithText:@"复制成功"];
    [CZProgressHUD hideAfterDelay:1.5];
}


+ (instancetype)elementViewImage:(NSString *)imageUrl
{
    GXElementView *elementView = [[GXElementView alloc] init];
    elementView.x = 10;
    elementView.width = SCR_WIDTH - 20;
    elementView.backgroundColor = UIColorFromRGB(0x0E0504);
    elementView.layer.shadowOpacity = 1;
    elementView.layer.shadowColor = UIColorFromRGB(0x9E65AE).CGColor;
    elementView.layer.cornerRadius = 7.5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageUrl]];
    //ImageH XXX
    //ImageW elementView.width - 20
    imageView.x = 10;
    imageView.y = 10;
    imageView.width = elementView.width - 20;
    imageView.height = imageView.image.size.height * (elementView.width - 20) / imageView.image.size.width;
    
    elementView.height = imageView.height + 20;
    [elementView addSubview:imageView];
    
    // 添加放大图片控件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showZoomImage:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
    return elementView;
}

+ (void)showZoomImage:(UIGestureRecognizer *)tap
{
    [GXZoomImageView showZoomImage:tap.view];
}

@end
