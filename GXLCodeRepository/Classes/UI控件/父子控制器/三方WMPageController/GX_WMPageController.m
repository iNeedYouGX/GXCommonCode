//
//  GX_WMPageController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/27.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GX_WMPageController.h"

@interface GX_WMPageController ()
/** <#注释#> */
@property (nonatomic, strong) NSArray *mainTitles;
@end

@implementation GX_WMPageController
- (NSArray *)mainTitles
{
    if (_mainTitles == nil) {
        _mainTitles = @[@"每日精选", @"宣传素材"];
    }
    return _mainTitles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)gx_menuViewStyle
{
    WMPageController *hotVc = (WMPageController *)self;
    hotVc.selectIndex = 0;
    hotVc.menuViewStyle = WMMenuViewStyleDefault;
    hotVc.menuItemWidth = 40;
    NSString *margin = [NSString stringWithFormat:@"%lf", (SCR_WIDTH - 160 - 44) / 3.0];
    hotVc.itemsMargins = @[@"22", margin, margin, margin, @"22"];
    hotVc.titleFontName = @"PingFangSC-Medium";
    hotVc.titleColorNormal = UIColorFromRGB(0xFFFFFF);
    hotVc.titleColorSelected = UIColorFromRGB(0xFFD224);
    hotVc.titleSizeNormal = 18;
    hotVc.titleSizeSelected = 18;
}

- (void)loadView
{
    [super loadView];
    self.selectIndex = 0;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuViewLayoutMode = WMMenuViewLayoutModeLeft;   // Item 紧靠屏幕左侧


    self.progressWidth = 30;
    self.progressHeight = 3;
    self.progressColor = UIColorFromRGB(0xFFD224);
    self.progressViewBottomSpace = 3;

    self.automaticallyCalculatesItemWidths = NO;
    self.itemMargin = 21;
    self.titleFontName = @"PingFangSC-Regular";
    self.titleColorNormal = UIColorFromRGB(0xFFFFFF);
    self.titleColorSelected = UIColorFromRGB(0xFFD224);
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 14;
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
    menuView.backgroundColor = UIColorFromRGB(0xE25838);
    return CGRectMake(0, (IsiPhoneX ? 88 : 64), SCR_WIDTH, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, (IsiPhoneX ? 88 : 64) + 33, SCR_WIDTH, SCR_HEIGHT - ((IsiPhoneX ? 88 : 64) + 33 + (IsiPhoneX ? 83 : 49)));
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
