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

@interface GXPostWordController () <UITextViewDelegate>
/** toolbar */
@property (nonatomic, strong) GXAddTagToobar *toolbar;
@end

@implementation GXPostWordController
#pragma mark - 设置导航栏的文字属性
- (void)setupNavAttribut
{
    // 设置导航标题文字大小. (UI_APPEARANCE_SELECTOR可统一设置)
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24]}];
    
    /** 右边的标题文字以及样式 */
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post:)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 开始时候不能点击
    // 右边不能点颜色
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateDisabled];
    // 右边文字颜色
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    //知识点:  要强制刷新一下, 不刷新设置的disable不会变颜色. (也可在viewDidAppear中设置, 但是不好看)
    [self.navigationController.navigationBar layoutIfNeeded];
    
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
    
    // 设置toolbar
    [self setupToolbar];
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
    GXPlaceholderTextView *textView = [[GXPlaceholderTextView alloc] initWithFrame:self.view.bounds];
    textView.placeHolder = @"请输入文字";
    textView.delegate = self;
    [self.view addSubview:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChange:(NSNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
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

@end
