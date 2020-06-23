//
//  GXCustomPickerView.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/6/11.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXCustomPickerView.h"
#import "GXCustomDatePickerView.h"

@interface GXCustomPickerView ()
/** <#注释#> */
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) GXCustomDatePickerView *pickerView;

@end

@implementation GXCustomPickerView

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请点击";
        _textField.x = 15;
        _textField.width = SCR_WIDTH - 30;
        _textField.height = 44;
    }
    return _textField;
}

- (GXCustomDatePickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [GXCustomDatePickerView customDatePickerViewConfirmAction:^(NSString * _Nonnull dataStr) {
            NSLog(@"%@", dataStr);
        } cancelAction:^{
            [self.view endEditing:YES];
        }];
        _pickerView.backgroundColor = RANDOMCOLOR;
        _pickerView.width = SCR_WIDTH - 30;
        _pickerView.y = 10;
        _pickerView.x = 15;
        _pickerView.height = 100;
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField];
    
    self.textField.inputView = self.pickerView;
}

// 设置dataPickerView
- (void)createPickerView
{
    // 初始化DatePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.backgroundColor = RANDOMCOLOR;
    datePicker.y = CZGetY(self.textField) + 30;
    datePicker.width = SCR_WIDTH;
    datePicker.height = 300;
//    [self.view addSubview:datePicker];
    
    //设置时间输入框的键盘框样式为时间选择器
    self.textField.inputView = datePicker;
    
    // 设置地区
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    datePicker.locale= locale;
    
    // 系统的显示模式
    //UIDatePickerModeTime    // 下午 5 33
    // UIDatePickerModeDate   // 2020年 6月  11日
    //UIDatePickerModeDateAndTime  // 6月11日 周三 下午 5 3
    //UIDatePickerModeCountDownTimer  // 0 hours  1min
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //设置当前显示的时间
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = @"yyyy-MM-dd";
    [datePicker setDate:[dateFormat dateFromString:@"2020-04-03"]];
    
    // 设置显示最大时间
    datePicker.maximumDate = [NSDate date];
    
    // 监听datePicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)dateChange:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [dateFormat stringFromDate:datePicker.date];
    NSLog(@"%@", dateStr);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
//    [self.textField resignFirstResponder];
}





@end
