#import "NSURL+BCHelper.h"

@implementation NSURL (BCHelper)

+ (nullable instancetype)bc_URLWithString:(NSString *)URLString {
    // 兼容url特殊符号URLWithString返回nil处理
    NSURL *URL = [NSURL URLWithString:URLString];
    if (!URL || [URL isEqual:[NSNull null]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        URL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
#pragma clang diagnostic pop
    }
    return URL;
}
@end
