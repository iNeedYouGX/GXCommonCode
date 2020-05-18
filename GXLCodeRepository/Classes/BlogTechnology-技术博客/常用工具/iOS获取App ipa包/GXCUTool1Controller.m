//
//  GXCUTool1Controller.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/12.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXCUTool1Controller.h"

@interface GXCUTool1Controller ()
@property (nonatomic, strong) UIScrollView *scrollerView;
@end

@implementation GXCUTool1Controller

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollerView];
    
    [self example1];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
}

- (void)example1
{
    [self MTitle:@"1. 首先 去Mac上的App Store下载Apple Configurator 2"];
    
    [self STitle:@"(1). iphone连接上Mac，点击Apple Configurator 2 菜单中->账户->登陆（用连接设备的Apple ID）"];
    [self MImg:@"20a2fec57f929726"];
    
    [self STitle:@"(2). 所有设备->选中当前iPhone->添加->应用，找到您想要ipa的那个应用->添加"];
    [self MImg:@"6f3813bcbbfab587.png"];
    [self MImg:@"acba1fe67c44b454.png"];
    [self MImg:@"c626d7de9280c7eb.png"];
    
    
    [self MTitle:@"2. 如果已安装当前应用，会提示\"该应用已经存在是否需要替换？\"， 此时，不要点任何按钮！不要点任何按钮！不要点任何按钮！"];
    [self MImg:@"8a3b35362e650101.png"];
    
    
    [self MTitle:@"3. 打开Finder前往文件夹, 前往下面路径"];
    [self STitle:@"~/Library/Group Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Assets/TemporaryItems/MobileApps/"];
    
}

- (void)MTitle:(NSString *)title
{
    GXElementLabel *mainLabel = [GXElementLabel elementLabelMainTitle:title];
    mainLabel.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:mainLabel];
}

- (void)STitle:(NSString *)title
{
    GXElementView *elementView = [GXElementView elementViewTitle:title];
    elementView.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:elementView];
}

- (void)MImg:(NSString *)imgUrl
{
    GXElementView *elementImage = [GXElementView elementViewImage:imgUrl];
    elementImage.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:elementImage];
}





@end
