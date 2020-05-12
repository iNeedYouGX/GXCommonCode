//
//  GX_WMPageStyleOneController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/4/1.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GX_WMPageStyleOneController.h"

@interface GX_WMPageStyleOneController ()
/** <#注释#> */
@property (nonatomic, strong) NSArray *mainTitles;
@end

@implementation GX_WMPageStyleOneController

- (void)gx_menuViewStyle3
{
    // WMMenuViewLayoutModeScatter, // 默认的布局模式, item 会均匀分布在屏幕上，呈分散状
    // WMMenuViewLayoutModeLeft,    // Item 紧靠屏幕左侧
    // WMMenuViewLayoutModeRight,   // Item 紧靠屏幕右侧
    // WMMenuViewLayoutModeCenter,  // Item 紧挨且居中分布
    self.selectIndex = 0;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;

    self.menuViewContentMargin = 50; // 距离左右的间距


//    self.progressWidth = 30;
    self.progressHeight = 10;
    self.progressColor = UIColorFromRGB(0xFFD224);
    self.progressViewBottomSpace = 3;
    self.progressViewCornerRadius = 2;


    self.automaticallyCalculatesItemWidths = YES;
//    self.itemMargin = 10;
    self.titleFontName = @"PingFangSC-Regular";
    self.titleColorNormal = UIColorFromRGB(0xFFFFFF);
    self.titleColorSelected = UIColorFromRGB(0xFFD224);
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 14;

}



- (void)gx_menuViewStyle2
{
    // WMMenuViewLayoutModeScatter, // 默认的布局模式, item 会均匀分布在屏幕上，呈分散状
    // WMMenuViewLayoutModeLeft,    // Item 紧靠屏幕左侧
    // WMMenuViewLayoutModeRight,   // Item 紧靠屏幕右侧
    // WMMenuViewLayoutModeCenter,  // Item 紧挨且居中分布
   self.selectIndex = 0;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuViewLayoutMode = WMMenuViewLayoutModeLeft;


//    self.progressWidth = 30;
    self.progressHeight = 10;
    self.progressColor = UIColorFromRGB(0xFFD224);
    self.progressViewBottomSpace = 3;
    self.progressViewCornerRadius = 2;


    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 20;
    self.titleFontName = @"PingFangSC-Regular";
    self.titleColorNormal = UIColorFromRGB(0xFFFFFF);
    self.titleColorSelected = UIColorFromRGB(0xFFD224);
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 14;

}

- (void)gx_menuViewStyle1
{
    // 自定义间隙
    WMPageController *hotVc = (WMPageController *)self;
    hotVc.selectIndex = 0;
    hotVc.menuViewStyle = WMMenuViewStyleDefault;
    hotVc.menuItemWidth = 60;

    NSString *margin = [NSString stringWithFormat:@"%lf", (SCR_WIDTH - hotVc.menuItemWidth * 4 - 80 - 10) / 3.0];
    hotVc.itemsMargins = @[@"80", margin, margin, margin, @"10"];
    hotVc.titleFontName = @"PingFangSC-Medium";
    hotVc.titleColorNormal = UIColorFromRGB(0xFFFFFF);
    hotVc.titleColorSelected = UIColorFromRGB(0xFFD224);
    hotVc.titleSizeNormal = 14;
    hotVc.titleSizeSelected = 14;
}


- (void)loadView
{
    [super loadView];
    if (self.index == 1) {
        [self gx_menuViewStyle1];
    } else if (self.index == 2) {
        [self gx_menuViewStyle2];
    } else if (self.index == 3) {
        [self gx_menuViewStyle3];
    }

}

- (NSArray *)mainTitles
{
    if (_mainTitles == nil) {
        _mainTitles = @[@"每日精选", @"宣传素材", @"每日每日精选", @"宣传素材"];
    }
    return _mainTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = RANDOMCOLOR;
            return vc;
        }
        case 1:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = RANDOMCOLOR;
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
    menuView.backgroundColor = RANDOMCOLOR; // UIColorFromRGB(0xE25838);
    return CGRectMake(0, 0, SCR_WIDTH, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    NSLog(@"%lf", self.view.height);
    return CGRectMake(0, 50, SCR_WIDTH, self.view.height - 50);
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info
{
    NSString *text = [NSString stringWithFormat:@"测评--%@", info[@"title"]];
    NSLog(@"----%@", text);
    if ([info[@"title"] isEqualToString:@"关注"] || [info[@"title"] isEqualToString:@"推荐"]) {
    }
    if (![info[@"title"] isEqualToString:@"精选"]) {

    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"starScrollAd" object:nil];
    }
}

@end
