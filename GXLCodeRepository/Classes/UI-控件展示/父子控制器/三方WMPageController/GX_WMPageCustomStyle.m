//
//  GX_WMPageCustomStyle.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/6.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GX_WMPageCustomStyle.h"

@interface GX_WMPageCustomStyle ()
/** <#注释#> */
@property (nonatomic, strong) NSArray *mainTitles;

@end

@implementation GX_WMPageCustomStyle

- (void)loadView
{
    self.selectIndex = 0;
    self.menuViewStyle = WMMenuViewStyleDefault;
    self.automaticallyCalculatesItemWidths = YES;
    
    
    // item设置
    self.itemMargin = 10;
    
    
    // 设置字体
    self.titleFontName = @"PingFangSC-Medium";
    
    self.titleColorNormal = UIColorFromRGB(0x989898);
    self.titleSizeNormal = 16;
    
    self.titleColorSelected = UIColorFromRGB(0xE25838);
    self.titleSizeSelected = 16;
    [super loadView];
}

- (NSArray *)mainTitles
{
    if (_mainTitles == nil) {
        _mainTitles = @[@"每日精选", @"宣传素材", @" 每日精选", @"宣传素材"];
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
}

- (WMMenuItem *)menuView:(WMMenuView *)menu initialMenuItem:(WMMenuItem *)initialMenuItem atIndex:(NSInteger)index
{
    WMMenuItem *Item = initialMenuItem;
    Item.textAlignment = NSTextAlignmentCenter;
    Item.layer.borderWidth = 0.5;
    Item.layer.borderColor = UIColorFromRGB(0x989898).CGColor;
    Item.layer.cornerRadius = 3;
    return Item;
}

- (void)menuView:(WMMenuView *)menu didLayoutItemFrame:(WMMenuItem *)menuItem atIndex:(NSInteger)index
{
    menuItem.height = 28;
    menuItem.width += 10;
    menuItem.centerY = 25;
    NSLog(@"%@", NSStringFromCGRect(menuItem.frame));
}

//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index
//{
//    return 71;
//}

- (void)menuView:(WMMenuView *)menu didSelectedItem:(WMMenuItem *)indexItem currentItem:(WMMenuItem *)currentItem
{
    NSLog(@"--indexItem:%@--\n\n\n--currentItem:%@", indexItem, currentItem);
    indexItem.layer.borderColor = UIColorFromRGB(0xE25838).CGColor;
    if (indexItem != currentItem){
        currentItem.layer.borderColor = UIColorFromRGB(0x989898).CGColor;
    }
}
@end
