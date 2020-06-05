//
//  GXChangeAllJsonDataController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/6/4.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXChangeAllJsonDataController.h"
#import "GXNetTool.h"
@interface GXChangeAllJsonDataController ()

@end

@implementation GXChangeAllJsonDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *url = @"file:///Users/gxl/Desktop/searchGoods.json";
//    NSString *url = [[NSBundle mainBundle] URLForResource:@"searchGoods" withExtension:@"json"].absoluteString;
    [GXNetTool GetNetWithUrl:url body:param header:nil response:GXResponseStyleJSON success:^(id result) {
        if ([result[@"msg"] isEqualToString:@"success"]) {
            //获取隐私政策版本号
            NSLog(@"%@", result);
            
            
            
            NSDictionary *dic = result;
            dic = [dic changeAllStringValue];
            
            
            NSString *list = dic[@"data"][@"wechat"];
            
            NSString *str = [list stringByAppendingFormat:@"%@", @"dddd"];
            
            
            
            [dic writeToFile:@"/Users/gxl/Desktop/getHong.plist" atomically:YES];
         
            
        }
    } failure:^(NSError *error) {}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
