//
//  GXMVVMDesignPatternControlller.m
//  GXLCodeRepository
//
//  Created by GX on 2022/1/18.
//  Copyright © 2022 JasonBourne. All rights reserved.
//

#import "GXMVVMDesignPatternControlller.h"
#import "GXMVVMDesignPatternModelView.h"
#import <BCFoundation/BCFoundationUtils.h>

@interface GXMVVMDesignPatternControlller ()
/** <#注释#> */
@property (nonatomic, strong) GXMVVMDesignPatternModelView *viewModel;
@end

@implementation GXMVVMDesignPatternControlller
#pragma mark - Cycle lift
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"------------");
    [self.viewModel fetchDataSouce];
    NSLog(@"------------");
    [self subscribeSignals];
    NSLog(@"------------");
}

#pragma mark - Signals
- (void)subscribeSignals
{
    @BCWeakify(self);
    [self.viewModel.updateEvent setNext:^(NSString * _Nullable event) {
        @BCStrongify(self);
        NSLog(@"------------");
    }];
}


#pragma mark - getter/setter
- (GXMVVMDesignPatternModelView *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[GXMVVMDesignPatternModelView alloc] init];
    }
    return _viewModel;
}


@end
