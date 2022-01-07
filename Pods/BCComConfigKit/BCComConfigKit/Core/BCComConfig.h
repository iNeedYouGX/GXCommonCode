//
//  BCComConfig.h
//  Pod
//
//  Created by Basic on 2018/7/7.
//  组件配置数据

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCComConfig : NSObject
//MARK: - 自定义配置
/** 通用设置项，key-value，从主工程BCComConfig.json中读取 */
@property (nonatomic, strong, readonly) NSDictionary *setting;
/** 主题设置项，key-value，从主工程BCComConfig_theme.json中读取 */
@property (nonatomic, strong, readonly) NSDictionary *theme;
/** 详细设置项，key-value，从主工程BCComConfig_info.json中读取 */
@property (nonatomic, strong, readonly) NSDictionary *info;

//MARK: - 字体配置
/** 默认nil，也就是 systemFont */
@property (nonatomic, copy) NSString *fontName;
/** 默认nil，也就是 boldSystemFont */
@property (nonatomic, copy) NSString *fontNameBold;

//MARK: - 主题颜色配置
/** 主题色,默认0xFFDA44 */
@property (nonatomic, strong) UIColor *defaultColor;
/** 淡 主题色,默认defaultColor 0.7的Alpha */
@property (nonatomic, strong) UIColor *lightDefaultColor;
/** 深 主题色,默认defaultColor */
@property (nonatomic, strong) UIColor *deepDefaultColor;

//MARK: - 常用颜色配置
/** 默认333333 */
@property (nonatomic, strong) UIColor *blackColor;
/** 轻微黑色，默认0x666666 */
@property (nonatomic, strong) UIColor *lightBlackColor;
/** 中轻微黑色，默认0x9E9E9E */
@property (nonatomic, strong) UIColor *bitLightBlackColor;
/** 更轻微黑色，默认0x999999*/
@property (nonatomic, strong) UIColor *littleBlackColor;
/** 全局不可用的颜色，灰色风格，默认0xDADBDA */
@property (nonatomic, strong) UIColor *disableColor;
/** 错误提示颜色，一般是红色,默认0xFF5856 */
@property (nonatomic, strong) UIColor *errTipColor;
/** 分割线颜色，默认0xF3F3F3 */
@property (nonatomic, strong) UIColor *splitColor;

//MARK: - 导航栏配置
/** 导航栏 标题颜色，默认 blackColor */
@property (nonatomic, strong) UIColor *navTitleColor;
/** 导航栏 按钮颜色，默认 blackColor */
@property (nonatomic, strong) UIColor *navBtnColor;
/** 导航栏 按钮disable颜色，默认 blackColor */
@property (nonatomic, strong) UIColor *navBtnDisColor;
/** 导航栏 back img，默认 @"nav_back" */
@property (nonatomic, strong) UIImage *navBackImg;
/** 导航栏 close img，默认 @"nav_closed_black" */
@property (nonatomic, strong) UIImage *navCloseImg;
/** 导航栏 shadow img，默认 UIImage new */
@property (nonatomic, strong) UIImage *navShadowImg;
/** 导航栏 背景色，默认0xFDD843 */
@property (nonatomic, strong) UIColor *navBgColor;
/** 导航栏 分割线颜色，默认 nil */
@property (nonatomic, strong) UIColor *navSplitColor;
/** 导航栏 进度颜色，默认 FFFFFF */
@property (nonatomic, strong) UIColor *navProgressColor;

//MARK: - ViewController 配置
/** vc 背景色，默认0xF1F2F3 */
@property (nonatomic, strong) UIColor *vcBgColor;

//MARK: - 输入框配置
/** textField tint color，默认nil，使用系统的 */
@property (nonatomic, strong) UIColor *tfTintColor;

//MARK: - Cell配置
/** cell 正常背景色，默认UIColor.whiteColor */
@property (nonatomic, strong) UIColor *cellBgColor;
/** cell 选中背景色，默认 nil  */
@property (nonatomic, strong) UIColor *cellBgSelectedColor;
/** cell 不可用背景色，默认 nil */
@property (nonatomic, strong) UIColor *cellBgDisableColor;

//MARK: - 搜索框
/** 搜索框背景色，默认白色 */
@property (nonatomic, strong) UIColor *searchBgColor;

//MARK: - text 配置
/** 淡色背景，高亮 文本，正常color，，默认 defaultColor */
@property (nonatomic, strong) UIColor *lightTextColor;
/** 淡色背景, 高亮 文本， 轻微 color，默认 lightTextColor x 0.8 */
@property (nonatomic, strong) UIColor *lightTextSlightColor;
/** 淡色背景，高亮 文本，不可用 color，默认 lightTextColor x 0.6  */
@property (nonatomic, strong) UIColor *lightTextDisableColor;
/** 主题色背景下（深色背景），淡色 文本， 正常 color，默认 UIColor.whiteColor */
@property (nonatomic, strong) UIColor *lightBgTextColor;
/** 主题色背景下（深色背景），淡色 文本， 轻微 color，默认 lightBgTextColor x 0.8 */
@property (nonatomic, strong) UIColor *lightBgSlightTextColor;
/** 主题色背景下（深色背景），淡色 文本， 不可用 color，默认 lightBgTextColor x 0.6 */
@property (nonatomic, strong) UIColor *lightBgTextDisableColor;
/** 主题色背景下浅绿色 */
@property (nonatomic, strong) UIColor *lightGreenColor;
//MARK: - 操作按钮配置
/** 主 行动按钮 正常 背景色，默认使用 defaultColor */
@property (nonatomic, strong) UIColor *btnBgColor;
/** 主 行动按钮 正常 标题颜色，默认使用 blackColor */
@property (nonatomic, strong) UIColor *btnTitleColor;
/** 主 行动按钮 按下 背景色，默认 btnBgColor */
@property (nonatomic, strong) UIColor *btnPressBgColor;
/** 主 行动按钮 按下 标题颜色，默认使用 btnTitleColor  */
@property (nonatomic, strong) UIColor *btnPressTitleColor;
/** 主 行动按钮 不可用 背景色，默认 btnBgColor+alpha0.5 */
@property (nonatomic, strong) UIColor *btnDisableBgColor;
/** 主 行动按钮 不可用 标题颜色，默认使用 btnTitleColor+alpha0.5  */
@property (nonatomic, strong) UIColor *btnDisableTitleColor;

/** 次 行动按钮 正常背景色，默认 btnBgColor */
@property (nonatomic, strong) UIColor *minorBtnBgColor;
/** 次 行动按钮 正常标题颜色，默认 btnTitleColor */
@property (nonatomic, strong) UIColor *minorBtnTitleColor;
/** 次 行动按钮 不可用背景色，默认 btnDisableBgColor */
@property (nonatomic, strong) UIColor *minorBtnDisableBgColor;
/** 次 行动按钮 不可用标题颜色，默认 btnDisableTitleColor  */
@property (nonatomic, strong) UIColor *minorBtnDisableTitleColor;

//MARK: - 标签按钮配置，一般适用于多选的标签
/** 标签按钮 正常背景色，默认使用 UIColor.whiteColor */
@property (nonatomic, strong) UIColor *tagBgColor;
/** 标签按钮 正常标题颜色，默认使用 blackColor */
@property (nonatomic, strong) UIColor *tagTitleColor;
/** 标签按钮 正常边框颜色，默认使用 0xcccccc */
@property (nonatomic, strong) UIColor *tagBorderColor;
/** 标签按钮 选中背景色，默认 tagBgColor */
@property (nonatomic, strong) UIColor *tagSelectedBgColor;
/** 标签按钮 选中标题颜色，默认使用 defaultColor  */
@property (nonatomic, strong) UIColor *tagSelectedTitleColor;
/** 标签按钮 选中边框颜色，默认使用 defaultColor */
@property (nonatomic, strong) UIColor *tagSelectedBorderColor;

//MARK: - 进度条
/** 进度条 背景色，默认使用 0xF2F2F2 */
@property (nonatomic, strong) UIColor *progressBgColor;
/** 进度条 填充的颜色，默认使用 progressIndicatorColor*0.8 */
@property (nonatomic, strong) UIColor *progressFillColor;
/** 进度条 指示器颜色，默认使用 defaultColor */
@property (nonatomic, strong) UIColor *progressIndicatorColor;

//MARK: - 第三方配置
/** 通用连接*/
@property (nonatomic, strong) NSString *universalLinks;
/** Buyly appid*/
@property (nonatomic, strong) NSString *buylyAppId;
/** wx appid*/
@property (nonatomic, strong) NSString *wechatAppId;
/** 友盟*/
@property (nonatomic, strong) NSString *umConfigureKey;

//MARK: - system
+ (nonnull instancetype)config;
///  默认实例，等价 config（config是系统旧的初始化方法，swift访问不到）
+ (nonnull instancetype)shared;

//MARK: - 字体
///  正常的字体
- (UIFont * (^)(CGFloat) )bcFont;

///  加粗的字体
- (UIFont * (^)(CGFloat) )bcBoldFont;

//MARK: - APP
/// app项目名称 从BCComConfig_info.json文件里取appName的值
- (NSString *)appName;

///  app版本号 如果在BCComConfig_info.json配置了则取配置中的版本否则取系统的版本
- (NSString *)appVersion;

///  对应服务器accountType
- (NSInteger)accountType;

//MARK: - helper
///  获取config 文件里的bool
/// @param key 要获取的key
BOOL BCComConfigBoolValue(NSString *key);

///  获取config 文件里的float值
/// @param key 要获取的key
/// @param defaultValue defaultValue 默认值
CGFloat BCComConfigFloatValue(NSString *key, CGFloat defaultValue);
///  获取config 文件里的颜色
/// @param key 要获取的key
/// @param defaultValue 默认值
UIColor * _Nullable BCComConfigColorValue(NSString *key, UIColor *_Nullable defaultValue);
///  获取config 文件里的 string
/// @param key 要获取的key
/// @param defaultValue 默认值
NSString * _Nullable BCComConfigStringValue(NSString *key, NSString *_Nullable defaultValue);
/// 获取 info 文件里的配置项
/// @param key 配置项的key
/// @param defaultValue 默认值
NSString * _Nullable BCComConfigInfoString(NSString *key, NSString *_Nullable defaultValue);
/// 获取 theme 文件中的颜色
/// @param key 颜色key
/// @param defaultColor 默认颜色
UIColor * _Nullable BCComConfigThemeColor(NSString *key, UIColor *_Nullable defaultColor);

@end

NS_ASSUME_NONNULL_END
