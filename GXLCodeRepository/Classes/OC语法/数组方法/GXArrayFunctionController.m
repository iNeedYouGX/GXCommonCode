//
//  GXArrayFunctionController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/11.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXArrayFunctionController.h"

@interface GXArrayFunctionController ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@end

@implementation GXArrayFunctionController
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
     label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 17];;
     label.numberOfLines = 0;
     label.textAlignment = NSTextAlignmentCenter;
     label.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
     label.x = 10;
     label.width = SCR_WIDTH - 20;
     CGSize size = [label sizeThatFits:CGSizeMake(label.width, 10)];
     label.height = size.height;
    return label;
}

- (UILabel *)createSubLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 13];;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        label.center = CGPointMake(label.superview.width / 2, label.superview.height / 2);
    });
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
    [self.scrollerView addSubview:[self createLabel:@"1. 让数组里面的控件执行同一个方法"]];
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
    label.text =
    @"for (int i = 0; i < 3; i++) {\n"
        @"\tCGFloat w = 30;\n"
        @"\tCGFloat h = 30;\n"
        @"\tCGFloat x = 10 + (i * (w + 10));\n"
        @"\tCGFloat y = 20;\n"
        @"\tUIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];\n"
        @"\tv.backgroundColor = [UIColor redColor];\n"
        @"\t[shareView addSubview:v];\n"
    @"}\n"
    @"dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\n"
        @"\t/** 让数组里面的所有控件执行同一个方法 */\n"
        @"\t[shareView.subviews makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:[UIColor greenColor]];\n"
    @"});";
    //----
    
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 13];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    CGSize size = [label sizeThatFits:CGSizeMake(SCR_WIDTH - 40, 10)];
    label.x = 10;
    label.y = 10;
    label.width = size.width;
    label.height = size.height;
    
    shareView.height = label.height + 20;
    
    [shareView addSubview:label];
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(generalPaste:)];
    [label addGestureRecognizer:tap];
}

/** 复制到剪切板 */
- (void)generalPaste:(UITapGestureRecognizer *)tap
{
    UILabel *label = tap.view;
    UIPasteboard *posteboard = [UIPasteboard generalPasteboard];
    posteboard.string = label.text;
    [CZProgressHUD showProgressHUDWithText:@"复制成功"];
    [CZProgressHUD hideAfterDelay:1.5];
}

@end
