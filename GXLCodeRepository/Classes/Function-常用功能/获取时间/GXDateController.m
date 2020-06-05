//
//  GXDateController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/26.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXDateController.h"

@interface GXDateController ()

@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation GXDateController

- (UIScrollView *)scrollerView
{
    if (_scrollerView == nil) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
        //    scrollerView.backgroundColor = RANDOMCOLOR;
        _scrollerView.pagingEnabled = NO;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.scrollerView];
    
    [self example1];
    [self example2];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
}

- (void)example1
{
    [GXElementLabel elementLabelMainTitle:@"1. 创建当前时间" containView:self.scrollerView];
    NSString *subStr = @"NSDate *date = [NSDate date];";
    [GXElementView elementViewTitle:subStr containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"2. 创建当前时间10秒后的时间" containView:self.scrollerView];
    NSString *subStr1 = @"NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];";
    [GXElementView elementViewTitle:subStr1 containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"3. 创建从1970-1-1 00:00:00时间10秒后的时间" containView:self.scrollerView];
    NSString *subStr2 = @"NSDate *date = [NSDate dateWithTimeIntervalSince1970:10];";
    [GXElementView elementViewTitle:subStr2 containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"4. 创建一个未来时间" containView:self.scrollerView];
    NSString *subStr3 = @"NSDate *date = [NSDate distantFuture];";
    [GXElementView elementViewTitle:subStr3 containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"6. 创建一个过去时间" containView:self.scrollerView];
    NSString *subStr4 = @"NSDate *date = [NSDate distantPast];";
    [GXElementView elementViewTitle:subStr4 containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"7. 返回比较早的那个时间" containView:self.scrollerView];
    [GXElementView elementViewTitle:@"NSDate *date = [date earlierDate:date1];" containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"8. 返回比较晚的那个时间" containView:self.scrollerView];
    [GXElementView elementViewTitle:@"NSDate *date = [date laterDate:date1];" containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"9. 获取两个时间的时间差(date1 - date2)" containView:self.scrollerView];
    [GXElementView elementViewTitle:@"NSTimeInterval interval1 = [date1 timeIntervalSinceDate:date2];" containView:self.scrollerView];
}

- (void)example2
{
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"GXDateControllerList" withExtension:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfURL:path];
    [GXElementLabel elementLabelMainTitle:@"10. 通过日历计算时间差" containView:self.scrollerView];
    [GXElementView elementViewTitle:dic[@"10"] containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"11. 通过日历获取星期字符串" containView:self.scrollerView];
    [GXElementView elementViewTitle:dic[@"11"] containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"12. 时间转化成秒" containView:self.scrollerView];
    [GXElementView elementViewTitle:dic[@"12"] containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"13. 获取当前时间戳" containView:self.scrollerView];
    [GXElementView elementViewTitle:dic[@"13"] containView:self.scrollerView];
    
    [GXElementLabel elementLabelMainTitle:@"14. 获取当前时间" containView:self.scrollerView];
    [GXElementView elementViewTitle:dic[@"14"] containView:self.scrollerView];
}


@end
