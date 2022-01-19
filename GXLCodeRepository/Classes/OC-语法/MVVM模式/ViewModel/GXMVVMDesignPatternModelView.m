//
//  GXMVVMDesignPatternModelView.m
//  GXLCodeRepository
//
//  Created by GX on 2022/1/18.
//  Copyright © 2022 JasonBourne. All rights reserved.
//

#import "GXMVVMDesignPatternModelView.h"
#import "GXNetTool.h"

@implementation GXMVVMDesignPatternModelView

#pragma mark - public method
- (void)fetchDataSouce
{
    NSLog(@"------------");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KindsOfViewData" ofType:@"json"];
    path = [NSString stringWithFormat:@"file://%@", path];
    [GXNetTool GetNetWithUrl:path body:nil header:nil response:GXResponseStyleJSON success:^(id result) {
        NSLog(@"------------");
        [self.updateEvent sendNext:@"update"];
        NSLog(@"------------");
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - private method


#pragma mark - setter/getter

- (BCEvent<NSString *> *)updateEvent
{
    if (_updateEvent == nil) {
        _updateEvent = [[BCEvent alloc] init];
    }
    return _updateEvent;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
