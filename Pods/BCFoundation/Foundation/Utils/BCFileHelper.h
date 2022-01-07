//
//  BCFileHelper.h
//  BCFoundation
//
//  Created by Basic on 2018/5/26.
//  基础组件 - 文件管理工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCFileHelper : NSObject

#pragma mark - 沙盒目录相关
/**
  沙盒的主目录路径

 @return return value description
 */
+ (NSString *)bc_homeDir;

/**
 沙盒中Documents的目录路径

 @return return value description
 */
+ (NSString *)bc_docDir;

/**
 沙盒中Library的目录路径

 @return return value description
 */
+ (NSString *)bc_libDir;

/**
 沙盒中tmp的目录路径

 @return return value description
 */
+ (NSString *)bc_tmpDir;

/**
 文件遍历
 
 @param path 目录的绝对路径
 @param deep 是否深遍历 (1. 浅遍历：返回当前目录下的所有文件和文件夹；
 2. 深遍历：返回当前目录下及子目录下的所有文件和文件夹)
 @return 遍历结果数组
 */
+ (NSArray<NSString *> *)bc_traversalFilesInDirectoryAtPath:(NSString *_Nullable)path deep:(BOOL)deep;


/**
 判断文件是否存在

 @param path 文件路径
 @return YES/No
 */
+ (BOOL)bc_isExistsAtPath:(NSString *_Nullable)path;

@end


NS_ASSUME_NONNULL_END
