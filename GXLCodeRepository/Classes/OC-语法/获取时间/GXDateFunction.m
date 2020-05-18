//
//  GXDateFunction.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/11.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXDateFunction.h"

@interface GXDateFunction ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@end

@implementation GXDateFunction

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

- (UILabel *)createLabel:(NSString *)text
{
     UILabel *label = [[UILabel alloc] init];
     label.text = text;
     label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 17];
     label.numberOfLines = 0;
     label.textAlignment = NSTextAlignmentCenter;
     label.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
     label.x = 10;
     label.width = SCR_WIDTH - 20;
     CGSize size = [label sizeThatFits:CGSizeMake(label.width, 10)];
     label.height = size.height;
    return label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollerView];
    
    [self example1];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
    
}

- (void)example1
{
    [self.scrollerView addSubview:[self createLabel:@"1. 当前的星期"]];
    UIView *shareView = [[UIView alloc] init];
    shareView.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    shareView.x = 10;
    shareView.height = 80;
    shareView.width = SCR_WIDTH - 20;
    shareView.backgroundColor = UIColorFromRGB(0x0E0504);
    shareView.layer.shadowOpacity = 1;
    shareView.layer.shadowColor = UIColorFromRGB(0x9E65AE).CGColor;
    shareView.layer.cornerRadius = 7.5;
    [self.scrollerView addSubview:shareView];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0x9E65AE);
    label.text = [self weekdayStringFromDate:[NSDate date]];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 13];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    CGSize size = [label sizeThatFits:CGSizeMake(SCR_WIDTH - 40, 10)];
    label.x = 10;
    label.y = 10;
    label.width = size.width;
    label.height = size.height;
    
    shareView.height = label.height + 20;
    
    [shareView addSubview:label];
}

// 得到当前的星期字符串
- (NSString *)weekdayStringFromDate:(NSDate*)inputDate {

    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/SuZhou"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
