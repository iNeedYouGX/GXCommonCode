//
//  NSDate+BCHelper.m
//  Pods
//
//  Created by Basic on 2017/4/4.
//
//

#import "NSDate+BCHelper.h"
#import "BCFoundationUtils.h"

@implementation NSDate (BCHelper)

#pragma mark - 格式化日期
static NSDateFormatter* dateFormatter;

- (NSString *)bc_formatDateWithFormat:(NSString*)format
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}

- (NSString *)bc_formatFullDate
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    NSString *formatResult = nil;
    if ([self bc_isToday]) {
        //今天
        dateFormatter.dateFormat = @"HH:mm:ss";
        formatResult = [dateFormatter stringFromDate:self];
        formatResult = [NSString stringWithFormat:@"%@ %@", BCLOC(@"今天"), formatResult];
    } else {
        //其他
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        formatResult = [dateFormatter stringFromDate:self];
    }
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)bc_formatDate:(NSString *)dateStr withStyle:(NSString *)style
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    dateFormatter.dateFormat = style;
    return [dateFormatter dateFromString:dateStr];
}

+ (NSString *)bc_formatDateStr:(NSTimeInterval )timeStamp withStyle:(NSString*)style
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    timeStamp = timeStamp / 1000.;
    dateFormatter.dateFormat = style;
    NSDate* receiveDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [dateFormatter stringFromDate:receiveDate];
}

+ (NSString *)bc_formatFullDateStr:(NSTimeInterval )timeStamp
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    timeStamp = timeStamp / 1000.;
    NSDate* receiveDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *formatResult = nil;
    if ([receiveDate bc_isToday]) {
        //今天
        dateFormatter.dateFormat = @"HH:mm:ss";
        formatResult = [dateFormatter stringFromDate:receiveDate];
        formatResult = [NSString stringWithFormat:@"%@ %@", BCLOC(@"今天"), formatResult];
    } else {
        //其他
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        formatResult = [dateFormatter stringFromDate:receiveDate];
    }
    return formatResult;
}
+ (NSString *)bc_formatFullDateStr:(NSInteger )timeStamp withHourStyle:(NSString *)style {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    timeStamp = timeStamp / 1000.;
    NSDate *receiveDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *formatResult = nil;
    dateFormatter.dateFormat = style;
    if ([receiveDate bc_isToday]) {
        //今天
        formatResult = [dateFormatter stringFromDate:receiveDate];
        formatResult = [NSString stringWithFormat:@"%@ %@", BCLOC(@"今天"), formatResult];
    } else if ([receiveDate bc_isYesterday]) {
        //昨天
        formatResult = [dateFormatter stringFromDate:receiveDate];
        formatResult = [NSString stringWithFormat:@"%@ %@", BCLOC(@"昨天"), formatResult];
    } else {
        //其他
        dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd %@", style];
        formatResult = [dateFormatter stringFromDate:receiveDate];
    }
    return formatResult;
}
#pragma mark - helper

+ (NSString *)bc_weekdayStr:(NSInteger)weekday
{
    NSString *weekdayStr = @"";
    switch (weekday) {
        case 1:{
            weekdayStr = @"周日";
        }break;
        case 2:{
            weekdayStr = @"周一";
        }break;
        case 3:{
            weekdayStr = @"周二";
        }break;
        case 4:{
            weekdayStr = @"周三";
        }break;
        case 5:{
            weekdayStr = @"周四";
        }break;
        case 6:{
            weekdayStr = @"周五";
        }break;
        case 7:{
            weekdayStr = @"周六";
        }break;
            
        default:
            break;
    }
    return weekdayStr;
}


+ (NSComparisonResult )bc_compareDate:(NSTimeInterval )timeinterval
{
    timeinterval = timeinterval/1000.0;
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    if (currentTime < timeinterval) {
        return NSOrderedDescending;
    } else if (currentTime == timeinterval) {
        return NSOrderedSame;
    } else {
        return NSOrderedAscending;
    }
}

- (BOOL)bc_isToday {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    return [today isEqualToDate:otherDate];
}

- (BOOL)bc_isTomorrow {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[[NSDate date] dateByAddingDays:1]];
    NSDate *tomorrow = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    return [tomorrow isEqualToDate:otherDate];
}

-(BOOL)bc_isYesterday{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[[NSDate date] dateBySubtractingDays:1]];
    NSDate *tomorrow = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    return [tomorrow isEqualToDate:otherDate];
}

#pragma mark - private

static NSCalendar *bc_calendarInstance = nil;
+ (NSCalendar *)bc_calendar {
    if (!bc_calendarInstance) {
        bc_calendarInstance = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return bc_calendarInstance;
}

- (NSDate *)dateByAddingDays:(NSInteger)days{
    NSCalendar *calendar = [[self class] bc_calendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of days.
 *
 *  @param days NSInteger - Number of days to subtract
 *
 *  @return NSDate - Date modified by the number of desired days
 */
- (NSDate *)dateBySubtractingDays:(NSInteger)days{
    NSCalendar *calendar = [[self class] bc_calendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1*days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

@end
