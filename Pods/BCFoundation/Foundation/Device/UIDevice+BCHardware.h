//
//  UIDevice+BCHardware.h
//  Pod
//
//  Created by Basic on 15/4/9.
//  Copyright (c) 2015年 funcity. All rights reserved.

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum {
    BCDeviceUnknown,
    BCDeviceiPhoneSimulator,
    BCDeviceiPhoneSimulatoriPhone,
    BCDeviceiPhoneSimulatoriPad,
    BCDevice1GiPhone,
    BCDevice3GiPhone,
    BCDevice3GSiPhone,
    BCDevice4iPhone,
    BCDevice5iPhone,
    BCDevice6iPhone,
    BCDevice6PiPhone,
    BCDevice1GiPod,
    BCDevice2GiPod,
    BCDevice3GiPod,
    BCDevice4GiPod,
    BCDevice1GiPad,
    BCDevice2GiPad,
    BCDevice3GiPad,
    BCDeviceAppleTV2,
    BCDeviceUnknownAppleTV,
    BCDeviceUnknowniPhone,
    BCDeviceUnknowniPod,
    BCDeviceUnknowniPad,
    BCDeviceIFPGA,
    BCDevice6SiPhone,
    BCDevice6SPiPhone,
    BCDevice7iPhone,
    BCDevice7PiPhone
} BCDevicePlatform;

@interface UIDevice (BCHardware)
#pragma mark  - system info
+ (NSString *) bc_hwmodel;
+ (NSUInteger) bc_cpuFrequency;
+ (NSUInteger) bc_busFrequency;

#pragma mark - memory
+ (NSUInteger) bc_totalMemory;
+ (NSUInteger) bc_userMemory;

#pragma mark - disk
+ (NSNumber *) bc_totalDiskSpace;
+ (NSNumber *) bc_freeDiskSpace;

#pragma mark - mac address
+ (NSString *) bc_macaddress;


#pragma mark - system

/**
 返回 systemName

 @return NSString
 */
+ (NSString *)bc_systemName;

/**
 返回 systemVersion

 @return NSString
 */
+ (NSString *)bc_systemVersion;

/**
 返回UUID

 @return NSString
 */
+ (NSString *)bc_UUID;

#pragma mark - 设备 类型

/**
 返回设备描述信息，不判断具体的设备型号

 @return 返回 iPhone7,1 字符串
 */
+ (NSString *) bc_platform;

/**
 返回设备类型

 @return 返回枚举 BCDevicePlatform
 */
+ (BCDevicePlatform ) bc_platformType;

/**
 返回设备型号

 @return 返回 iPhone7、iphone 7plus字符串
 */
+ (NSString *)bc_platformString;
/**
 获取对应屏幕大小的宽度
 
 @param iphone4Size iphone4Size、iphone5Size、iphone6Size、iphone6PSize、iphone7Size、iphone7pSize
 @return 对应实际屏幕的大小
 */
double bc_platformSize(NSNumber *iphone4Size,...);


#pragma mark - 设备 GPS
/**
 * 检测gps是否开启（不包括第一次询问）
 **/
+ (BOOL)bc_gpsAvailable;

#pragma mark - 设备 录音
/**
 * 是否支持录音
 **/
+ (BOOL)bc_recordAvailable;
/**
 * 是否支持陀螺仪
 **/
+ (BOOL)bc_gyroscopeAvailable;




#pragma mark - 设备 越狱
/**
 * 判断是否越狱
 **/
+ (BOOL)bc_jailBreak;


#pragma mark - 获取键盘window

/**
 获取键盘window

 @return return value description
 */
+ (UIView *)bc_keyboardView;
@end

NS_ASSUME_NONNULL_END
