//
//  GXShareToSocial.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/20.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXShareToSocial.h"

@implementation GXCustomActivity
// 自定义, 我也没有深入研究
// 这是用来标识自定义服务的一个字符串,而系统提供的服务的标识在上面我们已经提到了；为了迎合iOS SDK中的规范，我给它返回一个UIActivityTypeZSCustomMine
NSString *const UIActivityTypeZSCustomMine = @"GXCustomActivityMine";

- (NSString *)activityType
{
    return UIActivityTypeZSCustomMine;
}

- (NSString *)activityTitle
{
    //国际化
    return NSLocalizedString(@"ZS Custom", @"");
}


@end


@implementation GXShareToSocial

+ (void)shareToSocial
{
    // 设置中文, 是Project不是targets-->Info-->Localizations 添加 Chinese(simplified)
    NSString *shareTitle = @"分享的标题";
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    UIImage *shareImage1 = [UIImage imageNamed:@"1"];
    UIImage *shareImage2 = [UIImage imageNamed:@"2"];
    UIImage *shareImage3 = [UIImage imageNamed:@"3"];
    UIImage *shareImage4 = [UIImage imageNamed:@"4"];
    NSArray *activityItems = @[
        shareTitle,
        urlToShare,
        shareImage1,
        shareImage2,
        shareImage3,
        shareImage4,
    ]; // 必须要提供url 才会显示分享标签否则只显示图片

    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[[[GXCustomActivity alloc] init]]];

    //设定不想显示的平台和功能
    NSArray *excludeArray = @[
        UIActivityTypeAirDrop,
        UIActivityTypePrint,
        UIActivityTypePostToVimeo,
        UIActivityTypeMessage,
        UIActivityTypeMessage,
        UIActivityTypeMail,
    ];

    //不需要分享的图标
    activityVC.excludedActivityTypes = excludeArray;

    // 分享的回调
    [activityVC setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        NSLog(@"activityType: %@,\n completed: %d,\n returnedItems:%@,\n activityError:%@", activityType, completed, returnedItems, activityError);
    }];

    CURRENTVC(currentVc);
    [currentVc presentViewController:activityVC animated: YES completion: nil];

}

@end
