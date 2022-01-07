//
//  UIScrollView+BCHelper.h
//  BCUIKit
//
//  Created by Basic on 2019/4/1.
//

#import <UIKit/UIKit.h>


@interface UIScrollView (BCHelper)
/** 优先响应事件的class 列表，默认nil */
@property (nonatomic, strong) NSArray<Class > *bc_priorityCLSs;

@end

