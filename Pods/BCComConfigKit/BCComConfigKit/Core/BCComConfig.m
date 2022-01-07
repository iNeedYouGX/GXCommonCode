//
//  BCComConfig.m
//  Pod
//
//  Created by Basic on 2018/7/7.
//

#import "BCComConfig.h"
#import "BCComConfigDefine.h"

@interface BCComConfig ()
@property (nonatomic, strong, readwrite) NSDictionary *setting;
@property (nonatomic, strong, readwrite) NSDictionary *theme;
@property (nonatomic, strong, readwrite) NSDictionary *info;

@end

@implementation BCComConfig

//MARK: - system
static BCComConfig *kBCComConfigInstance;
+ (instancetype)config {
    static dispatch_once_t kBCComConfigOnceToken;
    dispatch_once(&kBCComConfigOnceToken, ^{
        kBCComConfigInstance = [[[self class] alloc] init];
    });
    return kBCComConfigInstance;
}

+ (instancetype)shared {
    return [BCComConfig config];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 配置项目信息
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BCComConfig_Info" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
        if (jsonData) {
            _info = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        } else {
    #ifdef DEBUG
            NSLog(@"[BCComConfig] BCComConfig_Info.json is empty");
    #endif
        }
    }
    return self;
}

//MARK: - 通用配置
- (NSDictionary *)setting {
    if (!_setting) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BCComConfig" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
        if (jsonData) {
            _setting = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        } else {
#ifdef DEBUG
            NSLog(@"[BCComConfig] BCComConfig.json is empty");
#endif
        }
    }
    return _setting;
}

- (NSDictionary *)theme {
    if (!_theme) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BCComConfig_Theme" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
        if (jsonData) {
            _theme = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        } else {
#ifdef DEBUG
            NSLog(@"[BCComConfig] BCComConfig_Theme.json is empty");
#endif
        }
    }
    return _theme;
}

//MARK: - 主题色配置
- (UIColor *)defaultColor
{
    if (!_defaultColor) {
        _defaultColor = self.themeHexColor(@"defaultColor", 0xFFDA44);
    }
    return _defaultColor;
}

- (UIColor *)lightDefaultColor
{
    if (!_lightDefaultColor) {
        _lightDefaultColor = self.themeDefaultColor(@"lightDefaultColor", [self.defaultColor colorWithAlphaComponent:0.7]);
    }
    return _lightDefaultColor;
}

- (UIColor *)deepDefaultColor {
    if (!_deepDefaultColor) {
        _deepDefaultColor = self.themeDefaultColor(@"deepDefaultColor", self.defaultColor);
    }
    return _deepDefaultColor;
}

//MARK: - vc背景
- (UIColor *)vcBgColor {
    if (!_vcBgColor) {
        _vcBgColor = self.themeHexColor(@"vcBgColor", 0xF1F2F3);
    }
    return _vcBgColor;
}

//MARK: - 常用颜色配置
- (UIColor *)blackColor
{
    if (!_blackColor) {
        _blackColor = bc_colorFromHex(0x333333);
    }
    return _blackColor;
}

- (UIColor *)lightBlackColor
{
    if (!_lightBlackColor) {
        _lightBlackColor = bc_colorFromHex(0x666666);
    }
    return _lightBlackColor;
}
- (UIColor *)bitLightBlackColor
{
    if (!_bitLightBlackColor) {
        _bitLightBlackColor = bc_colorFromHex(0x9E9E9E);
    }
    return _bitLightBlackColor;
}

- (UIColor *)littleBlackColor
{
    if (!_littleBlackColor) {
        _littleBlackColor = bc_colorFromHex(0x999999);
    }
    return _littleBlackColor;
}

- (UIColor *)splitColor
{
    if (!_splitColor) {
        _splitColor = self.themeHexColor(@"splitColor", 0xF4F4F4);
    }
    return _splitColor;
}

- (UIColor *)disableColor
{
    if (!_disableColor) {
        _disableColor = self.themeHexColor(@"disableColor", 0xD4D4D4);
    }
    return _disableColor;
}

- (UIColor *)errTipColor
{
    if (!_errTipColor) {
        _errTipColor = self.themeHexColor(@"errTipColor", 0xFF5856);
    }
    return _errTipColor;
}

//MARK: - text配置
- (UIColor *)lightTextColor {
    if (!_lightTextColor) {
        _lightTextColor = self.themeDefaultColor(@"lightTextColor", self.defaultColor);
    }
    return _lightTextColor;
}

- (UIColor *)lightTextSlightColor {
    if (!_lightTextSlightColor) {
        _lightTextSlightColor = self.themeDefaultColor(@"lightTextSlightColor", [self.lightTextColor colorWithAlphaComponent:0.8]);
    }
    return _lightTextSlightColor;
}

- (UIColor *)lightTextDisableColor {
    if (!_lightTextDisableColor) {
        _lightTextDisableColor = self.themeDefaultColor(@"lightTextDisableColor", [self.lightTextColor colorWithAlphaComponent:0.6]);
    }
    return _lightTextDisableColor;
}

- (UIColor *)lightBgTextColor {
    if (!_lightBgTextColor) {
        _lightBgTextColor = self.themeDefaultColor(@"lightBgTextColor", self.blackColor);
    }
    return _lightBgTextColor;
}

- (UIColor *)lightBgSlightTextColor {
    if (!_lightBgSlightTextColor) {
        _lightBgSlightTextColor = self.themeDefaultColor(@"lightBgSlightTextColor", [self.lightBgTextColor colorWithAlphaComponent:0.8]);
    }
    return _lightBgSlightTextColor;
}

- (UIColor *)lightBgTextDisableColor {
    if (!_lightBgTextDisableColor) {
        _lightBgTextDisableColor = self.themeDefaultColor(@"lightBgTextDisableColor", [self.lightBgTextColor colorWithAlphaComponent:0.6]);
    }
    return _lightBgTextDisableColor;
}
-(UIColor *)lightGreenColor{
    if (!_lightGreenColor) {
        _lightGreenColor = self.themeHexColor(@"lightGreenColor", 0x24BCA2);

    }
    return _lightGreenColor;
}

//MARK: - 导航栏配置
- (UIColor *)navBgColor {
    if (!_navBgColor) {
        _navBgColor = self.themeHexColor(@"navBgColor", 0xFDD843);
    }
    return _navBgColor;
}

- (UIColor *)navTitleColor {
    if (!_navTitleColor) {
        _navTitleColor = self.themeDefaultColor(@"navTitleColor", self.blackColor);
    }
    return _navTitleColor;
}

- (UIColor *)navBtnColor {
    if (!_navBtnColor) {
        _navBtnColor = self.themeDefaultColor(@"navBtnColor", self.blackColor);
    }
    return _navBtnColor;
}

- (UIColor *)navBtnDisColor {
    if (!_navBtnDisColor) {
        _navBtnDisColor = self.themeDefaultColor(@"navBtnDisColor", self.lightBlackColor);
    }
    return _navBtnDisColor;
}

- (UIColor *)navSplitColor {
    if (!_navSplitColor) {
        _navSplitColor = self.themeDefaultColor(@"navSplitColor", self.splitColor);
    }
    return _navSplitColor;
}

- (UIColor *)navProgressColor {
    if (!_navProgressColor) {
        _navProgressColor = self.themeHexColor(@"navProgressColor", 0x4A90E2);
    }
    return _navProgressColor;
}

- (UIImage *)navBackImg
{
    if (!_navBackImg) {
        return BCComConfigImageNamed(@"nav_back");
    }
    return _navBackImg;
}

- (UIImage *)navCloseImg
{
    if (!_navCloseImg) {
        return BCComConfigImageNamed(@"nav_closed_black");
    }
    return _navCloseImg;
}

- (UIImage *)navShadowImg
{
    if (!_navShadowImg) {
        return [[UIImage alloc] init];
    }
    return _navShadowImg;
}

//MARK: - 字体
- (NSString *)fontName {
    if (!_fontName) {
        if (self.theme[@"fontName"]) {
            _fontName = self.theme[@"fontName"];
        }
    }
    return _fontName;
}

- (NSString *)fontNameBold {
    if (!_fontNameBold) {
        if (self.theme[@"fontNameBold"]) {
            _fontName = self.theme[@"fontNameBold"];
        }
    }
    return _fontNameBold;
}

- (UIFont * (^)(CGFloat) )bcFont
{
    if (_fontName.length <= 0) {
        //系统字体
        return ^(CGFloat fontSize) {
                   return [UIFont systemFontOfSize:fontSize];
        };
    } else {
        //自定义字体
        return ^(CGFloat fontSize) {
                   return [UIFont fontWithName:self.fontName size:fontSize];
        };
    }
}

- (UIFont * (^)(CGFloat) )bcBoldFont
{
    if (_fontNameBold.length <= 0) {
        //系统字体
        return ^(CGFloat fontSize) {
                   return [UIFont boldSystemFontOfSize:fontSize];
        };
    } else {
        //自定义字体
        return ^(CGFloat fontSize) {
                   return [UIFont fontWithName:self.fontNameBold size:fontSize];
        };
    }
}

//MARK: - 输入框配置
- (UIColor *)tfTintColor {
    if (!_tfTintColor) {
        _tfTintColor = self.themeDefaultColor(@"tfTintColor", self.defaultColor);
    }
    return _tfTintColor;
}

//MARK: - 搜索框
- (UIColor *)searchBgColor {
    if (!_searchBgColor) {
        _searchBgColor = self.themeDefaultColor(@"searchBgColor", [UIColor whiteColor]);
    }
    return _searchBgColor;
}

//MARK: - 按钮配置
- (UIColor *)btnBgColor {
    if (!_btnBgColor) {
        _btnBgColor = self.themeDefaultColor(@"btnBgColor", self.defaultColor);
    }
    return _btnBgColor;
}

- (UIColor *)btnTitleColor {
    if (!_btnTitleColor) {
        _btnTitleColor = self.themeDefaultColor(@"btnTitleColor", self.blackColor);
    }
    return _btnTitleColor;
}

- (UIColor *)btnPressBgColor {
    if (!_btnPressBgColor) {
        _btnPressBgColor = self.themeDefaultColor(@"btnPressBgColor", self.defaultColor);
    }
    return _btnPressBgColor;
}

- (UIColor *)btnPressTitleColor {
    if (!_btnPressTitleColor) {
        _btnPressTitleColor = self.themeDefaultColor(@"btnPressTitleColor", self.btnTitleColor);
    }
    return _btnPressTitleColor;
}

- (UIColor *)btnDisableBgColor {
    if (!_btnDisableBgColor) {
        _btnDisableBgColor = self.themeDefaultColor(@"btnDisableBgColor", [self.btnBgColor colorWithAlphaComponent:0.5]);
    }
    return _btnDisableBgColor;
}

- (UIColor *)btnDisableTitleColor {
    if (!_btnDisableTitleColor) {
        _btnDisableTitleColor = self.themeDefaultColor(@"btnDisableTitleColor", [self.btnTitleColor colorWithAlphaComponent:0.5]);
    }
    return _btnDisableTitleColor;
}

- (UIColor *)minorBtnBgColor {
    if (!_minorBtnBgColor) {
        _minorBtnBgColor = self.themeDefaultColor(@"minorBtnBgColor", self.btnBgColor);
    }
    return _minorBtnBgColor;
}

- (UIColor *)minorBtnTitleColor {
    if (!_minorBtnTitleColor) {
        _minorBtnTitleColor = self.themeDefaultColor(@"minorBtnTitleColor", self.btnTitleColor);
    }
    return _minorBtnTitleColor;
}

- (UIColor *)minorBtnDisableBgColor {
    if (!_minorBtnDisableBgColor) {
        _minorBtnDisableBgColor = self.themeDefaultColor(@"minorBtnDisableBgColor", self.btnDisableBgColor);
    }
    return _minorBtnDisableBgColor;
}

- (UIColor *)minorBtnDisableTitleColor {
    if (!_minorBtnDisableTitleColor) {
        _minorBtnDisableTitleColor = self.themeDefaultColor(@"minorBtnDisableTitleColor", self.btnDisableTitleColor);
    }
    return _minorBtnDisableTitleColor;
}

//MARK: - Cell配置
- (UIColor *)cellBgColor {
    if (!_cellBgColor) {
        _cellBgColor = self.themeDefaultColor(@"cellBgColor", [UIColor whiteColor]);
    }
    return _cellBgColor;
}

//MARK: - 标签按钮配置
- (UIColor *)tagBgColor {
    if (!_tagBgColor) {
        _tagBgColor = self.themeDefaultColor(@"tagBgColor", [UIColor whiteColor]);
    }
    return _tagBgColor;
}

- (UIColor *)tagTitleColor {
    if (!_tagTitleColor) {
        _tagTitleColor = self.themeDefaultColor(@"tagTitleColor", self.blackColor);
    }
    return _tagTitleColor;
}

- (UIColor *)tagBorderColor {
    if (!_tagBorderColor) {
        _tagBorderColor = self.themeHexColor(@"tagBorderColor", 0xcccccc);
    }
    return _tagBorderColor;
}

- (UIColor *)tagSelectedBgColor {
    if (!_tagSelectedBgColor) {
        _tagSelectedBgColor = self.themeDefaultColor(@"tagSelectedBgColor", self.tagBgColor);
    }
    return _tagSelectedBgColor;
}

- (UIColor *)tagSelectedTitleColor {
    if (!_tagSelectedTitleColor) {
        _tagSelectedTitleColor = self.themeDefaultColor(@"tagSelectedTitleColor", self.defaultColor);
    }
    return _tagSelectedTitleColor;
}

- (UIColor *)tagSelectedBorderColor {
    if (!_tagSelectedBorderColor) {
        _tagSelectedBorderColor = self.themeDefaultColor(@"tagSelectedBorderColor", self.defaultColor);
    }
    return _tagSelectedBorderColor;
}

//MARK: - 进度条
- (UIColor *)progressBgColor {
    if (!_progressBgColor) {
        _progressBgColor = self.themeHexColor(@"progressBgColor", 0xF2F2F2);
    }
    return _progressBgColor;
}

- (UIColor *)progressFillColor {
    if (!_progressFillColor) {
        _progressFillColor = self.themeDefaultColor(@"progressFillColor", [self.progressIndicatorColor colorWithAlphaComponent:0.8]);
    }
    return _progressFillColor;
}

- (UIColor *)progressIndicatorColor {
    if (!_progressIndicatorColor) {
        _progressIndicatorColor = self.themeDefaultColor(@"progressIndicatorColor", self.defaultColor);
    }
    return _progressIndicatorColor;
}

//MARK: - 第三方
- (NSString *)universalLinks {
    if (!_universalLinks) {
        _universalLinks = _info[@"universalLinks"];
    }
    return _universalLinks;
}

- (NSString *)buylyAppId {
    if (!_buylyAppId) {
        _buylyAppId = _info[@"buylyAppId"];
    }
    return _buylyAppId;
}

- (NSString *)wechatAppId {
    if (!_wechatAppId) {
        _wechatAppId = _info[@"wechatAppId"];
    }
    return _wechatAppId;
}

- (NSString *)umConfigureKey {
    if (!_umConfigureKey) {
        _umConfigureKey = _info[@"umConfigureKey"];
    }
    return _umConfigureKey;
}

//MARK: - app
- (NSString *)appName {
    if (_info[@"appName"]) {
        return _info[@"appName"];
    }
    return nil;
}

- (NSString *)appVersion {
    if (_info[@"appVersion"]) {
        return _info[@"appVersion"];
    } else {
        NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
        return [bundleInfo valueForKey:@"CFBundleShortVersionString"];
    }
}

- (NSInteger)accountType {
    if (_info[@"accountType"]) {
        return [_info[@"accountType"] integerValue];
    }
    return 1;
}

//MARK: - help
- (UIColor *(^)(NSString *key, UInt32 hex) )themeHexColor {
    return ^(NSString *key, UInt32 hex) {
               if (self.theme[key]) {
                   NSString *colorStr = self.theme[key];
                   return bc_colorFromRGBStr(colorStr);
               } else {
                   return bc_colorFromHex(hex);
               }
    };
}

- (UIColor *(^)(NSString *key, UIColor *color) )themeDefaultColor {
    return ^(NSString *key, UIColor *color) {
               if (self.theme[key]) {
                   NSString *colorStr = self.theme[key];
                   return bc_colorFromRGBStr(colorStr);
               } else {
                   return color;
               }
    };
}

BOOL BCComConfigBoolValue(NSString *key)
{
    NSNumber *val = BCComConfig.shared.setting[key];
    BOOL result = NO;
    if ([val respondsToSelector:@selector(boolValue)]) {
        result = [val boolValue];
    }
    return result;
}

CGFloat BCComConfigFloatValue(NSString *key, CGFloat defaultValue)
{
    NSNumber *val = BCComConfig.shared.setting[key];
    CGFloat result = defaultValue;
    if ([val respondsToSelector:@selector(floatValue)]) {
        result = [val floatValue];
    }
    return result;
}

UIColor * BCComConfigColorValue(NSString *key, UIColor *defaultValue)
{
    NSString *val = BCComConfig.shared.setting[key];
    UIColor *result = defaultValue;
    if ([val isKindOfClass:[NSString class]] && val.length > 0) {
        result = bc_colorFromRGBStr(val);
    }
    return result;
}

NSString * BCComConfigStringValue(NSString *key, NSString *defaultValue)
{
    NSString *val = BCComConfig.shared.setting[key];
    if ([val isKindOfClass:[NSString class]]) {
        return val;
    }
    return defaultValue;
}

NSString * BCComConfigInfoString(NSString *key, NSString *defaultValue)
{
    NSString *val = BCComConfig.shared.info[key];
    if ([val isKindOfClass:[NSString class]]) {
        return val;
    }
    return defaultValue;
}

UIColor * BCComConfigThemeColor(NSString *key, UIColor *defaultColor)
{
    NSString *val = BCComConfig.shared.theme[key];
    if (val && [val isKindOfClass:[NSString class]]) {
        return bc_colorFromRGBStr(val);
    }
    return defaultColor;
}

//MARK: - utils

/// 16进制rgb 颜色转 UIColor
/// @param hex 16进制grb，如0x333333
static inline UIColor * bc_colorFromHex(UInt32 hex)
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

/// rgb字符串 转 UIColor
/// @param rgbStr rgb字符串，如"#333333"
static inline UIColor * bc_colorFromRGBStr(NSString *rgbStr)
{
    if (rgbStr.length < 6) return nil;
    if ([rgbStr hasPrefix:@"#"]) {
        rgbStr = [rgbStr substringFromIndex:1];
    }
    unsigned int _red, _green, _blue;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[rgbStr substringWithRange:exceptionRange]] scanHexInt:&_red];
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[rgbStr substringWithRange:exceptionRange]] scanHexInt:&_green];
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[rgbStr substringWithRange:exceptionRange]] scanHexInt:&_blue];
    UIColor *resultColor = [UIColor colorWithRed:_red / 255. green:_green / 255. blue:_blue / 255. alpha:1.];
    return resultColor;
}

@end
