//
//  GXPostWordController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/30.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXPostWordController.h"
#import "GXPlaceholderTextView.h"
#import "GXAddTagToobar.h"
#import "GXTestViewController.h"
#import "AppDelegate.h"

typedef void (^block)(NSArray *);

@interface GXPostWordController () <UITextViewDelegate>
/** toolbar */
@property (nonatomic, strong) GXAddTagToobar *toolbar;
/** <#注释#> */
@property (nonatomic, strong) GXPlaceholderTextView *textView;
/** <#注释#> */
@property (nonatomic, assign) BOOL fullscreen;
/** <#注释#> */
@property (nonatomic, copy) void (^TagBlock)(NSArray *tags);
@end
@implementation GXPostWordController
#pragma mark - 设置导航栏的文字属性e
- (void)setupNavAttribut
{
    // 设置导航标题文字大小. (UI_APPEARANCE_SELECTOR可统一设置)
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24]}];
    
    
    /** 开始时候不能点击 */
    self.navigationItem.rightBarButtonItem.enabled = NO;
    /** 右边的标题文字以及样式 */
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateDisabled];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    
    //知识点:  如果是UI_APPEARANCE_SELECTOR统一设置, 要强制刷新一下, 不刷新有渲染问题
//    [self.navigationController.navigationBar layoutIfNeeded];
    
     /** 左边的标题文字以及样式 */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle:)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发段子";
    // 设置导航栏
    [self setupNavAttribut];
    
    // 设置textView
    [self setupTextView];
    
//     设置toolbar
    [self setupToolbar];
    
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)setupToolbar
{
    GXAddTagToobar *toolbar = [GXAddTagToobar viewWithNib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - 设置输入框
- (void)setupTextView
{
    self.textView = [[GXPlaceholderTextView alloc] initWithFrame:self.view.bounds];
    self.textView.placeHolder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    self.textView.placeHolderColor = [UIColor redColor];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChange:(NSNotification *)notification
{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.toolbar.y = rect.origin.y - self.toolbar.height;
//    NSLog(@"%@", NSStringFromCGRect(self.toolbar.frame));
    
    // 这个监听还有动画的时间
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  rect.origin.y - SCR_HEIGHT);
    }];
    
    
}

#pragma mark - 发段子
- (void)post:(UIBarButtonItem *)item
{
//    GXTestViewController *vc = [[GXTestViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.allowRotation) {
        appDelegate.allowRotation =  NO;//设置竖屏
        [self setupOrientation:NO];
    } else {
        appDelegate.allowRotation = YES;//设置横屏
        [self setupOrientation:YES];
    }
    
   
    
    
}

- (void)setupOrientation:(BOOL)isPortrait{
    if (isPortrait) {
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }else{
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

#pragma mark - 取消
- (void)cancle:(UIBarButtonItem *)item
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    // hasText方法可以判断有没有文字
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


// 决定UIViewController可以支持哪些界面方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
}

//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

@end
