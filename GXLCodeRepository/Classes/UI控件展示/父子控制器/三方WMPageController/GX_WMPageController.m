//
//  GX_WMPageController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/27.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GX_WMPageController.h"
#import "GX_WMPageStyleOneController.h"
#import "GX_WMPageCustomStyle.h"

@interface GX_WMPageController ()
/** <#注释#> */
@property (nonatomic, strong) NSArray *mainTitles;
@end

@implementation GX_WMPageController
- (NSArray *)mainTitles
{
    if (_mainTitles == nil) {
        _mainTitles = @[@"自定义间隙", @"宣传素材", @"每日精选", @"修改框架高度自定义"];
    }
    return _mainTitles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;

}

- (void)loadView
{
    [super loadView];

    self.selectIndex = 0;
    self.menuViewStyle = WMMenuViewStyleLine;
   // WMMenuViewLayoutModeScatter, // 默认的布局模式, item 会均匀分布在屏幕上，呈分散状
   // WMMenuViewLayoutModeLeft,    // Item 紧靠屏幕左侧
   // WMMenuViewLayoutModeRight,   // Item 紧靠屏幕右侧
   // WMMenuViewLayoutModeCenter,  // Item 紧挨且居中分布
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    // 是否自动通过字符串计算 MenuItem 的宽度，默认为 NO.
    self.automaticallyCalculatesItemWidths = YES;
    
    // 每个item的间距
    self.itemMargin = 20;

    // 设置指示器高度
    self.progressHeight = 2.5;
    self.progressColor = UIColorFromRGB(0xFFD224);
    self.progressViewBottomSpace = 5;
    
    // 设置字体
    self.titleFontName = @"PingFangSC-Medium";
    self.titleColorNormal = UIColorFromRGB(0xFFFFFF);
    self.titleSizeNormal = 18;
    
    self.titleColorSelected = UIColorFromRGB(0xFFD224);
    self.titleSizeSelected = 18;
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.mainTitles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            GX_WMPageStyleOneController *vc = [[GX_WMPageStyleOneController alloc] init];
            vc.index = 1;
            return vc;
        }
        case 1:
        {
            GX_WMPageStyleOneController *vc = [[GX_WMPageStyleOneController alloc] init];
            vc.index = 2;
            return vc;
        }
        case 2:
        {
            GX_WMPageStyleOneController *vc = [[GX_WMPageStyleOneController alloc] init];
            vc.index = 3;
            return vc;
        }
        case 3:
        {
            GX_WMPageCustomStyle *vc = [[GX_WMPageCustomStyle alloc] init];
            vc.index = 4;
            return vc;
        }
        default:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = RANDOMCOLOR;
            return vc;
        }
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.mainTitles[index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.backgroundColor = RANDOMCOLOR;
    return CGRectMake(0, (IsiPhoneX ? 88 : 64), SCR_WIDTH, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, (IsiPhoneX ? 88 : 64) + 51, SCR_WIDTH, SCR_HEIGHT - ((IsiPhoneX ? 88 : 64) + 50 + (IsiPhoneX ? 83 : 49)));
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info
{
    NSString *text = [NSString stringWithFormat:@"测评--%@", info[@"title"]];
    NSLog(@"----%@", text);
    if ([info[@"title"] isEqualToString:@"关注"] || [info[@"title"] isEqualToString:@"推荐"]) {
    }
    if (![info[@"title"] isEqualToString:@"精选"]) {

    } else {
        
    }
}

@end
