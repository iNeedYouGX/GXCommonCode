//
//  GXWKWebViewController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/12.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface GXWKWebViewController ()<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) UIScrollView *scrollerView;
/** <#注释#> */
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation GXWKWebViewController

- (UIScrollView *)scrollerView
{
    if (_scrollerView == nil) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
        _scrollerView.backgroundColor = RANDOMCOLOR;
        _scrollerView.pagingEnabled = NO;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollerView];
    
    [self createWebView];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 1000);
    
    
    NSString *string = [NSString gx_stringWithFormat:@"%@", @"dddd", nil];
    NSString *string1 = [NSString gx_stringWithMoreString:@"1", @"2", @"3", @"4", nil];
}

#pragma mark - webView初始化
// 配置信息
- (WKWebViewConfiguration *)wkWebViewConfiguration
{
    
    //应用于 ajax 请求的 cookie 设置, 如果不设置, 下个页面,就找不到cookie了
    WKUserContentController *userContentController = WKUserContentController.new;
    
    NSString *cookieSource = [NSString stringWithFormat:@"document.cookie = '%@';", @"token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vc2hvcC5kYWxpYW5ncWluZy5jb20iLCJhdWQiOiJodHRwOi8vc2hvcC5kYWxpYW5ncWluZy5jb20iLCJpYXQiOjE1ODkyMTY3NTQsImV4cCI6MTk5MDQyNjM1NCwiaWQiOiIxMjUiLCJtb2JpbGUiOiIxNTIwMTAxMDAwMSJ9.cqoRYm11M87AC3JZLw77e_ZMKRc9s4i3Cv18lmoslr0"];
    WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookieSource injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    return config;
}

// 初始化
- (void)createWebView
{
    // 初始化
    CGRect rect = CGRectMake(10, 10, SCR_WIDTH - 20, 200);
    _webView = [[WKWebView alloc] initWithFrame:rect configuration:[self wkWebViewConfiguration]];
    [self.scrollerView addSubview:_webView];
    
    // 启动webView
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JStoOC" ofType:@"html"];
    NSURL *pathUrl = [[NSBundle mainBundle] URLForResource:@"JStoOC.html" withExtension:nil];
    
    NSString *url = @"http://shop-daliangqing.yidaoit.net/app/index.php?i=3&c=entry&m=ewei_shopv2&do=mobile";
    NSURL *urlPath = [NSURL URLWithString:url];
    
    // 这种方式设置cookie只能, 在request请求时, 来一次, 在到下一页就不好使了
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlPath];
    [request addValue:@"token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vc2hvcC5kYWxpYW5ncWluZy5jb20iLCJhdWQiOiJodHRwOi8vc2hvcC5kYWxpYW5ncWluZy5jb20iLCJpYXQiOjE1ODkyMTY3NTQsImV4cCI6MTk5MDQyNjM1NCwiaWQiOiIxMjUiLCJtb2JpbGUiOiIxNTIwMTAxMDAwMSJ9.cqoRYm11M87AC3JZLw77e_ZMKRc9s4i3Cv18lmoslr0" forHTTPHeaderField:@"Cookie"];
    [_webView loadRequest:request];
    
    // 一般设置
    _webView.scrollView.scrollEnabled = NO;
    _webView.backgroundColor = [UIColor grayColor];
    
    // webView的代理方法
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    // 监听webView的属性
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGSize size =  [change[@"new"] CGSizeValue];
    _webView.height = size.height;
//    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 10);
    self.scrollerView.contentSize = CGSizeMake(0, size.height + (IsiPhoneX ? 44 : 20) + 44 + 10 + (IsiPhoneX ? 34 : 0));
    NSLog(@"%@", NSStringFromCGSize(size));
}

// 代理
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面开始加载时调用");
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用");
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"提交发生错误时调用");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载失败时调用");
}

// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"接收到服务器跳转请求即服务重定向时之后调用");
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSLog(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    NSString *htmlHeadString = @"github://";
    if([urlStr hasPrefix:htmlHeadString]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            [[UIApplication sharedApplication] openURL:url];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    //用户身份信息
    NSURLCredential *newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"进程被终止时调用");
}


@end
