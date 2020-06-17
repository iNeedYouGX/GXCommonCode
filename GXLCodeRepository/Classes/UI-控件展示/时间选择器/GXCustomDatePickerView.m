//
//  GXCustomDatePickerView.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/6/12.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXCustomDatePickerView.h"

@interface GXCustomDatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
/** 获取当前日期 */
@property (nonatomic, strong) NSDateComponents *comp;
/** <#注释#> */
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign)NSInteger minShowYear;

/** 每月的天数 */
@property (nonatomic, assign) NSInteger days;

/** <#注释#> */
@property (nonatomic, strong) void (^confirmBlock)(NSString *dataStr);
@property (nonatomic, strong) void (^cancelBlock)(void);
@end

@implementation GXCustomDatePickerView

+ (instancetype)customDatePickerViewConfirmAction:(void (^)(NSString *dataStr))confirmBlock cancelAction:(void (^)(void))cancelBlock
{
    GXCustomDatePickerView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    view.confirmBlock = confirmBlock;
    view.cancelBlock = cancelBlock;
    return view;
}

- (void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 300);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - 获取当前的日期
- (NSDateComponents *)comp
{
    if (_comp == nil) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        // 获取当前日期
        NSDate *dt = [NSDate date];
        
        // 指定获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        
        // 获取不同时间字段的信息
        _comp = [gregorian components:unitFlags fromDate:dt];
    }
    return _comp;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    // 开始的日期
    self.minShowYear = self.comp.year - 1;
    
    // 选中的日期
    [self.pickerView selectRow:1 inComponent:0 animated:NO];
    
    // 根据选中的年和月确定一共多少天
    self.days = [self getDaysWithYear:self.comp.year month:1];
    
    [self.pickerView reloadAllComponents];
}

/** 取消 */
- (IBAction)cancel:(UIButton *)sender
{
    [self dismiss];
    self.cancelBlock();
}

/** 确定 */
- (IBAction)confirm:(UIButton *)sender
{
    NSInteger yearIndex = [_pickerView selectedRowInComponent:0];
    NSInteger monthIndex = [_pickerView selectedRowInComponent:1];
    NSInteger dayIndex = [_pickerView selectedRowInComponent:2];
    
    UILabel *yearLabel = [_pickerView viewForRow:yearIndex forComponent:0];
    UILabel *monthLabel = [_pickerView viewForRow:monthIndex forComponent:1];
    UILabel *dayLabel = [_pickerView viewForRow:dayIndex forComponent:2];
    
    self.confirmBlock([NSString stringWithFormat:@"%@-%@-%@", yearLabel.text, monthLabel.text, dayLabel.text]);
}

#pragma mark - dataSource
// 列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 3;
    } else if (component == 1) {
        return 12;
    } else {
        return self.days;
    }
}

#pragma mark - delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"哈哈";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in _pickerView.subviews) {
        if(singleLine.frame.size.height < 1) {
            singleLine.backgroundColor = UIColorFromRGB(0xEDEDED);
        }
    }
    
    NSString *text;
    if (component == 0) {
        text = [NSString stringWithFormat:@"%zd年", self.minShowYear + row];
    } else if (component == 1) {
        text =  [NSString stringWithFormat:@"%zd月", row + 1];
    } else if (component == 2) {
        text = [NSString stringWithFormat:@"%zd日", row + 1];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = UIColorFromRGB(0x656667);
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 12];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component != 2) {
        NSInteger yearIndex = [pickerView selectedRowInComponent:0];
        NSInteger monthIndex = [pickerView selectedRowInComponent:1];
        
        UILabel *yearLabel = [pickerView viewForRow:yearIndex forComponent:0];
        UILabel *monthLabel = [pickerView viewForRow:monthIndex forComponent:1];
        
        NSInteger year = [[yearLabel.text substringWithRange:NSMakeRange(0, monthLabel.text.length - 1)] integerValue];
        NSInteger month = [[monthLabel.text substringWithRange:NSMakeRange(0, monthLabel.text.length - 1)] integerValue];
    
        self.days = [self getDaysWithYear:year month:month];
        [pickerView reloadComponent:2];
    }
}

- (NSInteger)getDaysWithYear:(NSInteger)year month:(NSInteger)month
{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)) {
                return 29;
            } else {
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

@end
