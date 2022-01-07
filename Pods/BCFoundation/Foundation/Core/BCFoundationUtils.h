//
//  BCFoundationUtils.h
//  KDExample
//
//  Created by Basic on 2017/3/7.
//  Copyright © 2017年 naruto. All rights reserved.
//  公用的定义

#ifndef BCFoundationUtils_h
#define BCFoundationUtils_h

#import <Foundation/Foundation.h>


//MARK: - device info
//屏幕宽度
#define kBCSCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kBCSCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height
#define kBCSCREEN_SCALE             [UIScreen mainScreen].scale
//屏幕高度
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_3
#define kBCAPP_HEIGHT               [UIScreen mainScreen].bounds.size.height
#else
#define kBCAPP_HEIGHT               [UIScreen mainScreen].applicationFrame.size.height
#endif
#define kBCAppKeyWindow             [[[UIApplication sharedApplication] delegate] window]
#define kBCSystemVersion            [[UIDevice currentDevice].systemVersion floatValue]
#define kBCSCREEN_PhoneWidthRatio       (kBCSCREEN_WIDTH/375.0)//iphone屏幕宽度比例
#define kBCSCREEN_PhoneHeightRatio      (kBCSCREEN_HEIGHT/667.0)//iphone屏幕高度比例
#define kBCSCREEN_PadWidthRatio         (kBCSCREEN_WIDTH/1024.0)//ipad屏幕宽度比例
#define kBCSCREEN_PadHeightRatio        (kBCSCREEN_HEIGHT/768.0)//ipad屏幕高度比例

//MARK: -  tab bar
#define kBCTABBAR_HEIGHT            49

//MARK: -  navigation bar
//nav bar 高度
#define kBCNAVBAR_HEIGHT            ((kBCIsIPad?70:(kBCSTATUSBAR_HEIGHT+44)))

//MARK: - status bar
//status bar 高度
#define kBCSTATUSBAR_HEIGHT         ((UIApplication.sharedApplication.isStatusBarHidden ? (kBCIsIPhoneX ? 44 : 20) : UIApplication.sharedApplication.statusBarFrame.size.height))//状态栏高度，系统的高度
#define kBCSTATUSBAR_FixedHeight    (kBCIsIPhoneX? 35 : 0)//状态栏高度，实际占用高度,iphone x 这里不用44，因为实际现实上没有占44

//MARK: - ipad
//是否是ipad
#define kBCIsIPad   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//MARK: - iphone x 适配
//判断是否是 iphone x,判断是否有刘海
#define kBCIsIPhoneX ({\
BOOL iPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
    iPhoneX = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom > 0;\
}\
iPhoneX;\
})
//iphone x 适配
#define kBCScreenSafeAreaTop        (kBCIsIPhoneX? 24 : 0)//顶部安全距离
#define kBCScreenSafeAreaBottom     (kBCIsIPhoneX? 34 : 0)//底部安全距离
#define kBCScreenSafeFitBottom     (kBCIsIPhoneX? 34 : 10)//底部距离适配

//scrollView适配  [else {controller.automaticallyAdjustsScrollViewInsets = false;}]
#define kBCAdjustsScrollViewInsetNever(controller,view)\
do{\
    if(@available(iOS 11.0, *)) {\
        view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
    } else {\
        controller.automaticallyAdjustsScrollViewInsets = NO;\
    }\
}while(0)

/** 适配iphone x,调整 tableFooterView */
#define BCAdjustTableFooterView(tableView)\
do{\
    if(kBCScreenSafeAreaBottom>0) {\
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bc_width, kBCScreenSafeAreaBottom)];\
    }\
}while(0)

/** 适配iphone x,调整 tableFooterView */
#define BCAdjustTableFooterViewWithOffset(tableView, offset)\
do{\
    if(kBCScreenSafeAreaBottom>0 || (offset)>0) {\
        (tableView).tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (tableView).bc_width, kBCScreenSafeAreaBottom+(offset))];\
    }\
}while(0)

#define kBCIsIPhone4Width   (kBCSCREEN_WIDTH==320.0)//iphone4的宽度
#define kBCIsIPhone6PWidth  (kBCSCREEN_WIDTH==414)//iphone 6plus的宽度
#define kBCAdaptHeight(_x_)   (_x_/667.0*[[UIScreen mainScreen]bounds].size.height)
#define kBCAdaptWidth(_x_)    (_x_/375.0*[[UIScreen mainScreen]bounds].size.width)

#pragma mark - thread safe
#define dispatch_main_sync_bcsafe(block)\
do{\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }\
}while(0)


#define dispatch_main_async_bcsafe(block)\
do{\
    if(block){\
        if ([NSThread isMainThread]) {\
            block();\
        } else {\
            dispatch_async(dispatch_get_main_queue(), block);\
        }\
    }\
}while(0)




#pragma mark - log


#ifdef DEBUG

#define     BCLog(...)                  NSLog(__VA_ARGS__)
#define     BCLogs(format, ...)         NSLog((@"%s|" format), __FUNCTION__, ##__VA_ARGS__)
#define     BCLogDealloc()              BCLog(@"%@ dealloc",NSStringFromClass([self class]));

#else

#define     BCLogs(...)
#define     BCLog(...)
#define     NSLog(...)
#define     BCLogDealloc()              

#endif



#pragma mark - weak strong
#define     BCWeakObj(obj)              __weak typeof(obj) obj##Weak = obj
#define     BCStrongObj(obj)            __strong typeof(obj) obj = obj##Weak

#ifndef BCWeakify
#if DEBUG
#define BCWeakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define BCWeakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#endif
#endif

#ifndef BCStrongify
#if DEBUG
#define BCStrongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define BCStrongify(object) try{} @finally{} __typeof__(object) object = weak##_##    object;
#endif
#endif



#pragma mark - MutlLanguage

#define     BCLOC(a)                    NSLocalizedString(a, nil)
#define     BCLOCFromTable(a,table)     NSLocalizedStringFromTable(a, table, @"")


#pragma mark - BCFoundation Bundle
#define     BCFoundationImageNamed(name)                [UIImage imageNamed:[NSString stringWithFormat:@"BCFoundation.bundle/%@",name]]
#define     BCImageNamed(imgName)                       [UIImage imageNamed:imgName]

#pragma mark - String
#define     BCStrEmpty(a,b)     (a.length>0 && ![a isKindOfClass:[NSNull class]])?a:b
#define     kBCURLExpression    @"(?:(?:http|https)://)?[a-zA-Z0-9./?:@\\-_=#]+\\.([a-zA-Z0-9./?:@\\-_=#])*"//URL正则表达式
#define     kBCURLIntegralExpression    @"[a-zA-z]+://[^\\s]*"//完整的URL正则表达式
#define     kBCURLStr(str)   [NSURL URLWithString:(str)]
#define     kBCNilStr(str)   (str)?:@""//返回字符串，如果参数是nil，返回空字符串


#pragma mark - 单例简写
#define kBCNOTICENTER           [NSNotificationCenter defaultCenter]
#define kBCUSERDEFAULT          [NSUserDefaults standardUserDefaults]
#define kBCImgName(a)           [UIImage imageNamed:a]
#define kBCFont(a)              [UIFont systemFontOfSize:a]
#define kBCBFont(a)             [UIFont boldSystemFontOfSize:a]

#pragma mark - 图片
#define kBCImgWidthURL(_imgurl_, _widthstr_)   ((_widthstr_.length<=0)?_imgurl_:(([_imgurl_ containsString:@"?"])?[_imgurl_ stringByAppendingFormat:@"&imageView2/2/w/%@", _widthstr_]:[_imgurl_ stringByAppendingFormat:@"?imageView2/2/w/%@", _widthstr_]))

#define kBCImgIntWidthURL(_imgurl_, _width_)   ((_width_<=0)?_imgurl_:(([_imgurl_ containsString:@"?"])?[_imgurl_ stringByAppendingFormat:@"&imageView2/2/w/%d", (int)_width_]:[_imgurl_ stringByAppendingFormat:@"?imageView2/2/w/%d", (int)_width_]))

#endif /* BCFoundationUtils_h */
