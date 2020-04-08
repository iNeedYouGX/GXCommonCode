//
//  GX_WMPageController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2020/3/27.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GX_WMPageController.h"
#import "GX_WMPageStyleOneController.h"

@interface GX_WMPageController ()
/** <#注释#> */
@property (nonatomic, strong) NSArray *mainTitles;
@end

@implementation GX_WMPageController
- (NSArray *)mainTitles
{
    if (_mainTitles == nil) {
        _mainTitles = @[@"每日精选", @"宣传素材", @"每日精选"];
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
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;

    self.progressHeight = 2.5;
    self.progressColor = UIColorFromRGB(0xFFD224);
    self.progressViewBottomSpace = 5;

    self.automaticallyCalculatesItemWidths = YES;
    self.titleFontName = @"PingFangSC-Medium";
    self.titleColorNormal = UIColorFromRGB(0xFFFFFF);
    self.titleColorSelected = UIColorFromRGB(0xFFD224);
    self.titleSizeNormal = 18;
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"starScrollAd" object:nil];
    }
}

@end
