//
//  BCFileHelper.m
//  BCFoundation
//
//  Created by Basic on 2018/5/26.
//

#import "BCFileHelper.h"

@implementation BCFileHelper

#pragma mark - 遍历文件夹
+ (NSArray<NSString *> *)bc_traversalFilesInDirectoryAtPath:(NSString *)path deep:(BOOL)deep {
    if (path.length<=0) {
        return @[];
    }
    NSArray *listArr;
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (deep) {
        // 深遍历
        NSArray *deepArr = [manager subpathsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = deepArr;
        }else {
            listArr = nil;
        }
    } else {
        // 浅遍历
        NSArray *shallowArr = [manager contentsOfDirectoryAtPath:path error:&error];
        if (!error) {
            listArr = shallowArr;
        }else {
            listArr = nil;
        }
    }
    if (!listArr) {
        listArr = @[];
    }
    return listArr;
}
#pragma mark - 判断文件(夹)是否存在
+ (BOOL)bc_isExistsAtPath:(NSString *)path {
    if (path.length<=0) {
        return false;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
#pragma mark - 沙盒目录相关
+ (NSString *)bc_homeDir
{
    return NSHomeDirectory();
}

+ (NSString *)bc_docDir
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)bc_libDir
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];;
}

+ (NSString *)bc_tmpDir
{
    return NSTemporaryDirectory();
}

@end
