//
//  CZAlertView1Controller.m
//  BestCity
//
//  Created by JasonBourne on 2020/1/8.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "CZAlertView1Controller.h"

@interface CZAlertView1Controller ()
/** <#注释#> */
@property (nonatomic, weak) IBOutlet UIButton *closeBtn;
/** <#注释#> */
@property (nonatomic, weak) IBOutlet UIButton *caiBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *caiBtnBottomMargin;

/** 背景图片 */
@property (nonatomic, weak) IBOutlet UIImageView *backImageView;

@end

@implementation CZAlertView1Controller
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
//    self.view.frame = CGRectMake(100, 100, 100, 100);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RANDOMCOLOR;
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"-----");
    [super touchesBegan:touches withEvent:event];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIView *hitView = [super hitTest:point withEvent:event];
//    NSLog(@" CZAlertView1Controller- %@", [hitView class]);
//    return hitView;
//}

@end
