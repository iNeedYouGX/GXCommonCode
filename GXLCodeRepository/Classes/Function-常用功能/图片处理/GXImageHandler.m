//
//  GXImageHandler.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/20.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXImageHandler.h"
#import "UIImage+GXImageExtension.h"

@interface GXImageHandler ()

@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation GXImageHandler

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

- (UILabel *)createSubLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:17];
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
    [self example2];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
}

- (void)example1
{
    [self.scrollerView addSubview:[self createLabel:@"1. 改颜色"]];
    // 创建表
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"2"];
    imageView.size = imageView.image.size;
    imageView.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageColor:)];
    [imageView addGestureRecognizer:tap];
}

#pragma mark - 改变颜色
- (void)changeImageColor:(UIGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    imageView.image = [imageView.image gx_changeImageWithTintColor:RANDOMCOLOR];
}

- (void)example2
{
    [self.scrollerView addSubview:[self createLabel:@"2. 改亮度"]];
    // 创建表
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"2"];
    imageView.size = imageView.image.size;
    imageView.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageBright:)];
    [imageView addGestureRecognizer:tap];
}

#pragma mark - 改变亮度
- (void)changeImageBright:(UIGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    imageView.image = [imageView.image gx_changeImageBright];
}

@end
