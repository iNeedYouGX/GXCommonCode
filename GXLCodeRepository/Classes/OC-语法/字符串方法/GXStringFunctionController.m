//
//  GXStringFunctionController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/11.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXStringFunctionController.h"

@interface GXStringFunctionController ()
@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation GXStringFunctionController

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
    [GXElementLabel elementLabelMainTitle:@"1. 判断字符串是否包含其他元素" containView:self.scrollerView];
    
    NSString *subStr1 = @"if ([searchStr rangeOfString:@\"substr\"].location != NSNotFound) { \n//条件为真，表示字符串searchStr包含一个@\"substr\"\n }";
    [GXElementView elementViewTitle:subStr1 containView:self.scrollerView];
    
    
    [GXElementLabel elementLabelMainTitle:@"2. 截取固定位置字符并修改" containView:self.scrollerView];
    NSString *subStr2 = @"NSString *numberString = [subStr1 stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@\"****\"];";
    [GXElementView elementViewTitle:subStr2 containView:self.scrollerView];
    
}

@end
