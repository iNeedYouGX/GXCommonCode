//
//  NSString+BCHelper.m
//  Pods
//
//  Created by Basic on 2017/3/24.
//
//

#import "NSString+BCHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "BCFoundationUtils.h"

@implementation NSString (BCHelper)

///MARK: - string 校验
+ (BOOL )bc_isEmptyNull:(NSString *)str {
    if (!str) {
        return true;
    }
    else if ([str isKindOfClass:[NSNull class]])
        //NSNull
        return YES;
    else if ([str isKindOfClass:[NSNumber class]]) {
        //NSNumber
        if (!str) {
            return NO;
        }
        return YES;
    }
    else {
        //NSString
        str = [[self class] bc_trimString:str];
        if (str != nil && str.length > 0 && ![str isEqualToString:@"(null)"] && ![str isEqualToString:@""]) {
            return NO;
        }
        return YES;
    }
}

+ (NSString *)bc_trimString:(NSString *)str
{
    if (str.length<=0) {
        return @"";
    }
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (NSString*)bc_timestamp
{
    return [NSString stringWithFormat:@"%ld", time(NULL)*1000];
}


///MARK: - md5
- (NSString*)bc_md5
{
    
    if (self == nil || [self length] == 0)
        return nil;
    
    const char* value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return [outputString uppercaseString];
}

///MARK: - encode decode
-(NSString *)bc_encode
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge  CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    return encodedString;
    
}
-(NSString *)bc_decode
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    NSString*decodedString=(__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,(__bridge CFStringRef)self,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
#pragma clang diagnostic pop
    return decodedString;
}

///MARK: - 字符串转json
+ (id)bc_jsonObject:(NSString *)str
{
    if (![str isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (![[self class] bc_isEmptyNull:str]) {
        NSError* error = nil;
        NSData* postData = [str dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableLeaves error:&error];
        if (jsonObject != nil && error == nil) {
            return jsonObject;
        }
    }
    return nil;
}


///MARK: - 计算高度
+(CGSize)bc_autoSize:(NSString *)content font:(UIFont *)font
{
    if(!font){
        font=[UIFont systemFontOfSize:14];
    }
    if(content.length<=0){
        content = @"";
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
    if([[UIDevice currentDevice].systemVersion floatValue] < 7){
        return [content sizeWithFont:font];
    }
    else{
#endif
        return [content sizeWithAttributes: @{NSFontAttributeName: font}];
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
    }
#endif
}

+(CGSize)bc_autoSize:(NSString *)content constraint:(CGSize)constraint font:(UIFont *)font
{
    if(!font){
        font = [UIFont systemFontOfSize:14];
    }
    if(content.length<=0){
        content = @"";
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
    if([[UIDevice currentDevice].systemVersion floatValue] < 7){
        return [content sizeWithFont:font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    }
    else{
#endif
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        CGRect text_size = [content boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:NULL];
        return CGSizeMake(ceil(text_size.size.width),ceil(text_size.size.height));
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
    }
#endif
}

+ (CGFloat)bc_autoWidth:(NSString *)string stringFont:(UIFont*)font
{
    if(!font){
        font=[UIFont systemFontOfSize:14];
    }
    if(string.length<=0){
        string = @"";
    }
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}
+ (CGFloat)bc_autoHeight:(NSString*)string stringFont:(UIFont*)font textWidth:(CGFloat)width
{
    if (string.length<=0) {
        return 0;
    }
    if(!font){
        font=[UIFont systemFontOfSize:14];
    }
    CGRect textRect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:nil];
    CGSize labelSize = textRect.size;
    
    return labelSize.height;
}
+ (CGFloat)bc_autoHeight:(NSString*)string stringFont:(UIFont*)font lineSpacing:(CGFloat)space textWidth:(CGFloat)width {
    if (string.length<=0) {
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    CGRect textRect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
    CGSize labelSize = textRect.size;
    
    return labelSize.height;
}
+ (CGFloat)bc_textViewHeightWithString:(NSString *)string stringFont:(UIFont *)font textWidth:(CGFloat)width attributes:(NSDictionary *)attrs {
    if (string.length<=0) {
        return 0;
    }
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    textView.textContainerInset = UIEdgeInsetsZero;
    textView.font = font;
    if (attrs) {
        textView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attrs];;
    }else{
       textView.text = string;
    }
    
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    return size.height;
}
static UILabel *__hightLabel;
+ (CGSize )bc_labelSizeWithString:(NSString *)string stringFont:(UIFont *)font textWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode )lineBreakMode{
    if (string.length<=0) {
        return CGSizeZero;
    }
    if (!__hightLabel) {
        __hightLabel = [[UILabel alloc] init];
        __hightLabel.numberOfLines = 0;
    }
    __hightLabel.font = font;
    __hightLabel.text = string;
    __hightLabel.lineBreakMode = lineBreakMode;
    CGSize retSize = [__hightLabel sizeThatFits:CGSizeMake(width, 0)];
    return CGSizeMake(ceil(retSize.width),ceil(retSize.height));
}

///MARK: - 关键字查找
- (NSArray *)bc_rangeString:(NSString*)subString {
    if (self.length<=0 || subString.length<=0) {
        return nil;
    }
    NSMutableArray* arrayRanges = [NSMutableArray array];
    NSRange rang = [self rangeOfString:subString options:NSCaseInsensitiveSearch];
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSNumber valueWithRange:rang]];
        NSRange rang1 = { 0, 0 };
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++) {
            if (0 == i) {
                location = rang.location + rang.length;
                length = self.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }
            else {
                location = rang1.location + rang1.length;
                length = self.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [self rangeOfString:subString options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            }
            else {
                [arrayRanges addObject:[NSNumber valueWithRange:rang1]];
            }
        }
        return [NSArray arrayWithArray:arrayRanges];
    }
    return nil;
}
- (NSArray<NSTextCheckingResult *> *_Nullable)bc_findKeyWithPrefix:(NSString *_Nonnull)prefix withSuffix:(NSString *_Nonnull)suffix {
    if (!prefix || !suffix) {
        return nil;
    }
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSError *error;
    NSString *regulaStr = [NSString stringWithFormat:@"%@((?!(%@|%@)).)*%@", prefix, prefix, suffix, suffix];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    for (NSInteger i = 0; i<arrayOfAllMatches.count; i++) {
        NSTextCheckingResult *match = arrayOfAllMatches[i];
        [results addObject:match];
    }
    return results;
}

//MARK: - 手机号、邮箱验证
+ (BOOL )bc_validCNMobile:(NSString *)phoneNum
{
    if(phoneNum.length<=0){
        return NO;
    }
    if(phoneNum.length == 11){
        return YES;
    }
    return NO;
}

+ (BOOL )bc_validMail:(NSString *)email
{
    if (!email) {
        return false;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if( [emailTest evaluateWithObject:email]){
        return YES;
    }
    else{
        return NO;
    }
}


///MARK: - 字符长度
- (NSInteger )bc_length
{
    __block NSInteger length = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        length++;
   }];
    return length;
}
-(NSString *)bc_substringToIndex:(NSUInteger)to {
    if(to<=0){
        return nil;
    }
    __block int length = 0;
    __block NSMutableString *strNew = [[NSMutableString alloc] init];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        length++;
        [strNew appendString:substring];
        if(length == to){
            *stop = YES;
        }
    }];
    return strNew;
}

//MARK: - URL 验证
+ (NSString *)bc_getValidURL:(NSString *)url {
    BOOL urlExpResult = [[self class] bc_containURL:url];
    if (!urlExpResult) {
        return nil;
    }
    NSRange protocolRange = [url rangeOfString:@"://"];
    if (protocolRange.location == NSNotFound) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    return url;
}

+ (BOOL )bc_containURL:(NSString *)url {
    if(url.length<=0){
        return NO;
    }
    NSRegularExpression *urlExp = [NSRegularExpression regularExpressionWithPattern:kBCURLExpression options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *urlResult = [urlExp firstMatchInString:url options:NSMatchingReportProgress range:NSMakeRange(0, url.length)];
    if (!urlResult || urlResult.range.location == NSNotFound) {
        return NO;
    }
    return YES;
}

+ (BOOL )bc_integralURL:(NSString *)url {
    if(url.length<=0){
        return NO;
    }
    NSRegularExpression *urlExp = [NSRegularExpression regularExpressionWithPattern:kBCURLIntegralExpression options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *urlResult = [urlExp firstMatchInString:url options:NSMatchingReportProgress range:NSMakeRange(0, url.length)];
    if (!urlResult || urlResult.range.location == NSNotFound) {
        return NO;
    }
    return YES;
}
///MARK: - Image URL
- (NSString *)bc_imageUrlWithWidth:(CGFloat)width {
    return [NSString stringWithFormat:@"%@?imageView2/0/w/%@",self,@(width)];
}
///MARK: - 手机号
+ (NSString *)bc_hidePhoneCoreNumber:(NSString *)string {
    if (!string) {
        return @"";
    }
    if (string.length < 8) {
        return string;
    }
    NSString *str1 = [string substringToIndex:3];
    NSString *str2 = [string substringFromIndex:string.length-4];
    return [NSString stringWithFormat:@"%@****%@",str1,str2];
}
///MARK: - 数字
+ (NSString *)bc_grepPointZero:(NSInteger )number {
    if ((number%100==0)) {
        return [NSString stringWithFormat:@"%@",@(number/100)];
    }
    NSString *pointStr = [NSString stringWithFormat:@"%.2f",number/100.];
    NSArray *arr = [pointStr componentsSeparatedByString:@"."];
    NSString *lastStr = [arr lastObject];
    
    NSInteger lastCount = 0;
    for(NSInteger i=lastStr.length-1; i>=0; i--){
        NSString *subStr = [lastStr substringWithRange:NSMakeRange(i, 1)];
        if (![subStr isEqualToString:@"0"]) {
            lastCount = i+1;
            break;
        }
    }
    if (lastCount == 0) {
        return [arr firstObject];
    }
    NSString *afterStr = [lastStr substringToIndex:lastCount];
    return [NSString stringWithFormat:@"%@.%@",[arr firstObject],afterStr];
}
+ (BOOL )bc_validNumeral:(NSString *)string {
    if (!string) {
        return false;
    }
   NSString *result = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(result.length > 0) {
        return NO;
    }
    return YES;
}
+ (NSString *)bc_seconds:(CGFloat )seconds withFormatted:(NSString *)format {
    if (!format) {
        return @"";
    }
    NSString *format_time = @"";
    if (seconds >= 3600) {
        NSString *str_hour = [NSString stringWithFormat:@"%02ld",(long)seconds/3600];
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",((long)seconds%3600)/60];
        NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
        format_time = [NSString stringWithFormat:@"%@%@%@%@%@",str_hour,format,str_minute,format,str_second];
    }else if (seconds >= 60) {
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",((long)seconds)/60];
        NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
        if ([format isEqualToString:@"'"]) {
            format_time = [NSString stringWithFormat:@"%@\'%@\"",str_minute,str_second];
        }else {
            format_time = [NSString stringWithFormat:@"%@%@%@",str_minute,format,str_second];
        }
    }else {
        NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds];
        if ([format isEqualToString:@"'"]) {
            format_time = [NSString stringWithFormat:@"00\'%@\"",str_second];
        }else {
            format_time = [NSString stringWithFormat:@"00%@%@",format,str_second];
        }
    }
    return format_time;
}

///MARK: - base64
- (NSString *)bc_base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)bc_base64DecodedString {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
///MARK: - emoji
+ (NSString *)bc_disableEmojiWith:(NSString *)text {
    if (text.length < 1) {
        return text;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length])withTemplate:@""];
    return modifiedString;
}
@end
