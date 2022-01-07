//
//  NSURL+BCHelper.h
//  BCFoundation
//
//  Created by Basic. on 2019/4/19.
//

#import <Foundation/Foundation.h>

@interface NSURL (BCHelper)


/**
 通过string返回NSURL

 @param URLString URL 字符串
 @return return value description
 */
+ (instancetype)bc_URLWithString:(NSString *)URLString;

@end

