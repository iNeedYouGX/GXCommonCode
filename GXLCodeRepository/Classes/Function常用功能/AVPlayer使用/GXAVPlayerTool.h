//
//  GXAVPlayerTool.h
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/17.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXAVPlayerTool : UIView
// 创建AVPlayer
+ (instancetype)aVPlayerFrame:(CGRect)frame andURLStr:(NSString *)url;

// 监听播放进度与状态的刷新
- (void)aVPlayerProgress:(void (^)(CGFloat scale, NSTimeInterval currentTime))block;

// 监听Status属性
- (void)aVAddObserverStatus:(void (^)(AVPlayerStatus status, AVPlayerItem *playerItem))avplayerStatusBlock;
// 监听播放完毕, 之后循环播放
- (void)moviePlayDidEnd;

// 设置视频播放位置
- (void)aVplayerToTime:(NSTimeInterval)time;

// 播放
- (void)start;

// 暂停
- (void)pause;
@end

NS_ASSUME_NONNULL_END
