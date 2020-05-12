//
//  GXShadowHandler.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/7.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXShadowHandler.h"

@interface GXShadowHandler ()
/** <#注释#> */
@property (nonatomic, strong) UIScrollView *scrollerView;
@end

@implementation GXShadowHandler

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
     label.font = [UIFont boldSystemFontOfSize:20];
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.scrollerView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"设置layer.shadowOpacity = 0~1之后, 默认shadowOffset为-3, shadowRadius为3"
                 @"\n下面两个不设置也是这个数"
                 @"\nxxx.layer.shadowOffset = CGSizeMake(0,-3); "
                 @"\nxxx.layer.shadowRadius = 3;";
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.y = 10;
    label.x = 10;
    label.width = SCR_WIDTH - 20;
    CGSize size = [label sizeThatFits:CGSizeMake(label.width, 10)];
    label.height = size.height;
    [self.scrollerView addSubview:label];
    
    
    [self example1];
    [self example2];
    [self example3];
    [self example4];
    [self example5];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
    
}

- (void)example1
{
    
    [self.scrollerView addSubview:[self createLabel:@"1. shadowColor-阴影颜色"]];
    //
    NSInteger flag = 0;
    while (flag < 2) {
        UIView *shareView = [[UIView alloc] init];
        shareView.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
        shareView.x = 10;
        shareView.height = 80;
        shareView.width = SCR_WIDTH - 20;
        shareView.backgroundColor = [UIColor whiteColor];
        shareView.layer.shadowOpacity = 1;
        shareView.layer.shadowColor = RANDOMCOLOR.CGColor;
        [self.scrollerView addSubview:shareView];
        flag++;
    }
}

- (void)example2
{
    [self.scrollerView addSubview:[self createLabel:@"2. shadowOpacity-阴影不透明度"]];
    
    NSInteger flag = 0;
    CGFloat opacity = 0;
    while (flag < 3) {
        UIView *shareView = [[UIView alloc] init];
        shareView.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
        shareView.x = 10;
        shareView.height = 80;
        shareView.width = SCR_WIDTH - 20;
        shareView.backgroundColor = [UIColor whiteColor];
        opacity += 0.3;
        shareView.layer.shadowOpacity = opacity;
        [self.scrollerView addSubview:shareView];
       [shareView addSubview:[self createSubLabel:[NSString stringWithFormat:@"shadowOpacity = %.2lf", opacity]]];
        flag++;
    }
}

- (void)example3
{
    [self.scrollerView addSubview:[self createLabel:@"3. shadowOffset-阴影偏移量"]];
    
    NSInteger flag = 0;
    while (flag < 7) {
        UIView *view = [[UIView alloc] init];
        view.y = CZGetY([self.scrollerView.subviews lastObject]) + 20;
        view.x = 10;
        view.height = 80;
        view.width = SCR_WIDTH - 20;
        view.backgroundColor = [UIColor whiteColor];
        view.layer.shadowOpacity = 1;
        if (flag == 0) {
            view.layer.shadowOffset = CGSizeMake(0, 0);
        } else if (flag == 1) {
            view.layer.shadowOffset = CGSizeMake(5, 0);
        } else if (flag == 2) {
            view.layer.shadowOffset = CGSizeMake(-5, 0);
        } else if (flag == 3) {
            view.layer.shadowOffset = CGSizeMake(0, 5);
        } else if (flag == 4) {
            view.layer.shadowOffset = CGSizeMake(0, -5);
        } else if (flag == 5) {
            view.layer.shadowOffset = CGSizeMake(5, 5);
        } else if (flag == 6) {
            view.layer.shadowOffset = CGSizeMake(-5, -5);
        }
        [self.scrollerView addSubview:view];
        [view addSubview:[self createSubLabel:[NSString stringWithFormat:@"shadowOffset = %@", NSStringFromCGSize(view.layer.shadowOffset)]]];
        flag++;
    }
}

- (void)example4
{
    [self.scrollerView addSubview:[self createLabel:@"4. shadowRadius-理解为阴影的宽度"]];
    
    NSInteger flag = 0;
    CGFloat shadowRadius = 0;
    while (flag < 3) {
        UIView *shareView = [[UIView alloc] init];
        shareView.backgroundColor = [UIColor yellowColor];
        shareView.y = CZGetY([self.scrollerView.subviews lastObject]) + 30;
        shareView.x = 10;
        shareView.height = 80;
        shareView.width = SCR_WIDTH - 20;
        shareView.layer.shadowOpacity = 1;
        shareView.layer.shadowOffset = CGSizeMake(0, 0);
        shareView.layer.shadowRadius = shadowRadius;
        [self.scrollerView addSubview:shareView];
       [shareView addSubview:[self createSubLabel:[NSString stringWithFormat:@"shadowRadius = %.2lf", shadowRadius]]];
        shadowRadius += 3;
        flag++;
    }
}

- (void)example5
{
    [self.scrollerView addSubview:[self createLabel:@"5. shadowPath-阴影路径"]];
    
    NSInteger flag = 0;
    while (flag < 1) {
        UIView *shareView = [[UIView alloc] init];
        shareView.backgroundColor = [UIColor yellowColor];
        shareView.y = CZGetY([self.scrollerView.subviews lastObject]) + 30;
        shareView.x = 10;
        shareView.height = 80;
        shareView.width = SCR_WIDTH - 20;
        shareView.layer.shadowOpacity = 1;
        shareView.layer.shadowOffset = CGSizeMake(0, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:shareView.bounds];
        shareView.layer.shadowPath = path.CGPath;
        [self.scrollerView addSubview:shareView];
        flag++;
    }
}

@end
