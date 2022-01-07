//
//  UIDevice+BCHardware.m
//  Pod
//
//  Created by Basic on 15/4/9.
//  Copyright (c) 2015年 funcity. All rights reserved.

#import "UIDevice+BCHardware.h"
#import "BCFoundationUtils.h"
#import "BCUUIDUtil.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CLLocationManager.h>



// UUID
#define kBCDEVICE_KEY_IDIC      @"com.bc.strong.keychain"
#define kBCDEVICE_KEY_UUID      @"uuid"


@implementation UIDevice (BCHardware)
#pragma mark  - system info
+ (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}
+ (NSString *) bc_hwmodel
{
    return [self getSysInfoByName:"hw.model"];
}
+ (NSUInteger) getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}
+ (NSUInteger) bc_cpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}
+ (NSUInteger) bc_busFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

#pragma mark - memory
+ (NSUInteger) bc_totalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}
+ (NSUInteger) bc_userMemory
{
    return [self getSysInfo:HW_USERMEM];
}
+ (NSUInteger) bc_maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}


#pragma mark - MAC addy
+ (NSString *) bc_macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    // NSString *outstring = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
    //                       *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}



#pragma mark - system
+ (NSString *)bc_systemName
{
    return [[UIDevice currentDevice] systemName];
}
+ (NSString *)bc_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (NSString *)bc_UUID
{
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    if (bundleId.length<=0) {
        bundleId = kBCDEVICE_KEY_IDIC;
    }
    NSDictionary *udic = (NSDictionary *)[BCUUIDUtil bc_load:bundleId];
    NSString *uuid = udic[kBCDEVICE_KEY_UUID];
    if (!uuid) {
        //uuid 为空
        NSMutableDictionary *mudict = nil;
        if (!udic) {
            //keychain为空
            mudict = [NSMutableDictionary dictionary];
        } else {
            //uuid为空
            mudict = [NSMutableDictionary dictionaryWithDictionary:udic];
        }
        uuid = [BCUUIDUtil bc_uuid];
        mudict[kBCDEVICE_KEY_UUID] = uuid;
        [BCUUIDUtil bc_save:bundleId data:mudict];
    }
    return uuid;
}

#pragma mark - disk
+ (NSNumber *) bc_totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *) bc_freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark - platform
+ (NSString *) bc_platform
{
    return [self getSysInfoByName:"hw.machine"];
}
+ (BCDevicePlatform ) bc_platformType
{
    NSString *platform = [self bc_platform];
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return BCDeviceIFPGA;
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return BCDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return BCDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return BCDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return BCDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return BCDevice5iPhone;
    if ([platform isEqualToString:@"iPhone6,1"])    return BCDevice5iPhone;
    if ([platform isEqualToString:@"iPhone6,2"])    return BCDevice5iPhone;
    if ([platform isEqualToString:@"iPhone7,1"])    return BCDevice6PiPhone;
    if ([platform isEqualToString:@"iPhone7,2"])    return BCDevice6iPhone;
    if ([platform isEqualToString:@"iPhone8,1"])    return BCDevice6SiPhone;
    if ([platform isEqualToString:@"iPhone8,2"])    return BCDevice6SPiPhone;
    if ([platform isEqualToString:@"iPhone9,1"])    return BCDevice7iPhone;
    if ([platform isEqualToString:@"iPhone9,2"])    return BCDevice7PiPhone;
    // iPod
    if ([platform hasPrefix:@"iPod1"])             return BCDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return BCDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return BCDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return BCDevice4GiPod;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return BCDevice1GiPad;
    if ([platform hasPrefix:@"iPad2"])              return BCDevice2GiPad;
    if ([platform hasPrefix:@"iPad3"])              return BCDevice3GiPad;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return BCDeviceAppleTV2;
    
    if ([platform hasPrefix:@"iPhone"])             return BCDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return BCDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return BCDeviceUnknowniPad;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]){
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? BCDeviceiPhoneSimulatoriPhone : BCDeviceiPhoneSimulatoriPad;
    }
    return BCDeviceUnknown;
}
+ (NSString *)bc_platformString
{
    NSString *deviceString = [self bc_platform];
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])   return @"iPod Touch 1";
    if ([deviceString isEqualToString:@"iPod2,1"])   return @"iPod Touch 2";
    if ([deviceString isEqualToString:@"iPod3,1"])   return @"iPod Touch 3";
    if ([deviceString isEqualToString:@"iPod4,1"])   return @"iPod Touch 4";
    if ([deviceString isEqualToString:@"iPod5,1"])   return @"iPod Touch 5";
    if ([deviceString isEqualToString:@"iPod7,1"])   return @"iPod Touch 6";
    
    if ([deviceString isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    if ([deviceString isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])   return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,6"])   return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])   return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])   return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"])   return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])   return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])   return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])   return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])   return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])   return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])   return @"iPad Mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])   return @"iPad Mini 4";
    if ([deviceString isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])   return @"iPad Pro (9.7 inch)";
    if ([deviceString isEqualToString:@"iPad6,4"])   return @"iPad Pro (9.7 inch)";
    if ([deviceString isEqualToString:@"iPad6,7"])   return @"iPad Pro (12.9 inch)";
    if ([deviceString isEqualToString:@"iPad6,8"])   return @"iPad Pro (12.9 inch)";
    
    
    if ([deviceString isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return deviceString;
}

double bc_platformSize(NSNumber *iphone4Size,...)
{
    if(iphone4Size==nil){
        return 0;
    }
    va_list argList;
    va_start(argList, iphone4Size);
    NSNumber *tempSize = nil;
    NSMutableArray *listSize=[[NSMutableArray alloc] initWithCapacity:0];
    [listSize addObject:iphone4Size];
    while ((tempSize = va_arg(argList, NSNumber *))!=nil){
        [listSize addObject:tempSize];
    }
    va_end(argList);
    CGSize screenSize=[[UIScreen mainScreen] bounds].size;
    if(screenSize.width>=414 && screenSize.height>=736){
        // 【iphone 6plus 标准模式】
        if(listSize.count>3){
            return [listSize[3] doubleValue];
        }
    }
    else if(screenSize.width>=375 && screenSize.height>=667){
        // 【iphone 6plus 放大模式模式】【iPhone 6 标准模式】
        if(listSize.count>2){
            return [listSize[2] doubleValue];
        }
    }
    else if(screenSize.width>=320 && screenSize.height>=568){
        // 【iphone 6 放大模式模式】【iPhone 5 】【iPhone 5s 】【iPhone 5c 】
        if(listSize.count>1){
            return [listSize[1] doubleValue];
        }
    }
    else if(screenSize.width>=320 && screenSize.height>=480){
        // 【iphone 4 、4s】
        if(listSize.count>0){
            return [listSize[0] doubleValue];
        }
    }
    return [listSize[listSize.count-1] doubleValue];
}

#pragma mark - 设备 GPS
+ (BOOL)bc_gpsAvailable
{
    return !([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied);
}

#pragma mark - 设备 录音
+ (BOOL)bc_recordAvailable
{
    __block BOOL bCanRecord = YES;
    if (kBCSystemVersion >=7){
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]){
            [audioSession requestRecordPermission:^(BOOL granted) {
                if (granted){
                    bCanRecord = YES;
                }
                else
                {
                    bCanRecord = NO;
                }
            }];
        }
    }
    return bCanRecord;
}

+ (BOOL)bc_gyroscopeAvailable
{
    return [CLLocationManager headingAvailable];
    //#ifdef __IPHONE_4_0//4.0之后才有
    //    CMMotionManager *motionManager = [[CMMotionManager alloc]init];
    //    BOOL gyroscopeAvailable = motionManager.gyroAvailable;
    //    return gyroscopeAvailable;
    //#else
    //    return NO;
    //#endif
}



#pragma mark - 判断是否越狱
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])
+ (BOOL)bc_jailBreak
{
    const char* jailbreak_tool_pathes[] = {
        "/Applications/Cydia.app",
        "/Library/MobileSubstrate/MobileSubstrate.dylib",
        "/bin/bash",
        "/usr/sbin/sshd",
        "/etc/apt"
    };
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            return YES;
        }
    }
    return NO;
}




#pragma mark - 获取键盘window
+ (UIView *)bc_keyboardView
{
    UIWindow *toastDisplaywindow = [[[UIApplication sharedApplication] delegate] window];;
    for (UIWindow *temp in [[UIApplication sharedApplication] windows]){
        if (![[temp class] isEqual:[UIWindow class]]){
            toastDisplaywindow=temp;
        }
    }
    return toastDisplaywindow;
}
@end
