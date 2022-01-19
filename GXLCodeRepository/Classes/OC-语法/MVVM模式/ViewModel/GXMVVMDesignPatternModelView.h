//
//  GXMVVMDesignPatternModelView.h
//  GXLCodeRepository
//
//  Created by GX on 2022/1/18.
//  Copyright © 2022 JasonBourne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BCEventBus/BCEventBusKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXMVVMDesignPatternModelView : NSObject
/// 数据更新 Event
@property (nonatomic, strong) BCEvent<NSString *> *updateEvent;
/// 数据
@property (nonatomic, strong) NSMutableArray *dataSource;
/// 获取数据
- (void)fetchDataSouce;
@end

NS_ASSUME_NONNULL_END
