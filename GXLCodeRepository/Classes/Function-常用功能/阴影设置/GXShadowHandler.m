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
    
    [GXElementLabel elementLabelMainTitle:@"设置layer.shadowOpacity = 0~1之后, 默认shadowOffset为-3, shadowRadius为3"
    @"\n下面两个不设置也是这个数"
    @"\nxxx.layer.shadowOffset = CGSizeMake(0,-3); "
    @"\nxxx.layer.shadowRadius = 3;" containView:self.scrollerView];
    
    [self example1];
    [self example2];
    [self example3];
    [self example4];
    [self example5];
    [self example6];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
    
}

- (void)example1
{
    [GXElementLabel elementLabelMainTitle:@"1. shadowColor-阴影颜色" containView:self.scrollerView];
    
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
    [GXElementLabel elementLabelMainTitle:@"2. shadowOpacity-阴影不透明度" containView:self.scrollerView];
    
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
    [GXElementLabel elementLabelMainTitle:@"3. shadowOffset-阴影偏移量" containView:self.scrollerView];
    
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
    [GXElementLabel elementLabelMainTitle:@"4. shadowRadius-理解为阴影的宽度" containView:self.scrollerView];;
    
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
    [GXElementLabel elementLabelMainTitle:@"5. shadowPath-阴影路径" containView:self.scrollerView];
    
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

- (void)example6
{
    [GXElementLabel elementLabelMainTitle:@"6. 设置虚线" containView:self.scrollerView];
    NSInteger flag = 0;
    while (flag < 2) {
        UIView *shareView = [[UIView alloc] init];
        shareView.backgroundColor = [UIColor yellowColor];
        shareView.y = CZGetY([self.scrollerView.subviews lastObject]) + 30;
        shareView.x = 10;
        shareView.height = 80;
        shareView.width = SCR_WIDTH - 20;
        if (flag == 0) {
            [self gx_dottedLine:shareView];
        } else {
            [self gx_dottedLine1:shareView];
        }
        
        [self.scrollerView addSubview:shareView];
        flag++;
    }
}

- (void)gx_dottedLine:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
       
    //虚线的颜色
    border.strokeColor = UIColorFromRGB(0xFFE2B5).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    
    border.frame = view.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@8, @8];
    
    [view.layer addSublayer:border];
}

- (void)gx_dottedLine1:(UIView *)view {
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = UIColorFromRGB(0xD8D8D8).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    CGPathAddLineToPoint(path, NULL, view.width,0);
    
    
    //虚线的宽度
    border.lineWidth = 1.f;
    
    border.path = path;
    
    CGPathRelease(path);
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @4];
    
    [view.layer addSublayer:border];
}

@end
