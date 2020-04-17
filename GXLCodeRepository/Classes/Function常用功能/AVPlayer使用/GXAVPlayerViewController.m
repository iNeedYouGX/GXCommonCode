//
//  GXAVPlayerViewController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/17.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXAVPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "GXAVPlayerTool.h"

@interface GXAVPlayerViewController ()
/** */
@property (nonatomic, weak) IBOutlet UISlider *slider;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 播放器 */
@property (nonatomic, strong) GXAVPlayerTool *playerView;
@end

@implementation GXAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    // 第三步: 创建播放器
    NSString *localFilePath1 = [[NSBundle mainBundle] pathForResource:@"12秒nn" ofType:@"mp4"];
    GXAVPlayerTool *playerView = [GXAVPlayerTool aVPlayerFrame:CGRectMake(10, 10, 200, 200) andURLStr:localFilePath1];
    self.playerView = playerView;
    [self.view addSubview:playerView];
    
    // 播放进度与状态的刷新
    __weak __typeof(self) weakSelf = self;
    [playerView aVPlayerProgress:^(CGFloat scale, NSTimeInterval currentTime) {
        // 设置滑块的当前进度
        [weakSelf.progressView setProgress:scale animated:YES];
        weakSelf.slider.value = currentTime;
        // 设置显示的时间：以00:00:00的格式
        NSString *currentTimeStr = [weakSelf formatTimeWithTimeInterVal:currentTime];
        NSLog(@"当前的播放时间: %@", currentTimeStr);
    }];

    // 观察Status属性，成功之后得到视频的长度
    [playerView aVAddObserverStatus:^(AVPlayerStatus status, AVPlayerItem *playerItem) {
        if (status == 1) {
            //获取视频长度
            CMTime duration = playerItem.duration;
            NSTimeInterval count = CMTimeGetSeconds(duration);
            // 加载滑块
            self.slider.enabled = YES;
            self.slider.maximumValue = count;
            self.slider.value = 0;
            self.progressView.progress = 0;
        }
    }];

    

}

/** 播放 */
- (IBAction)start
{
    [self.playerView start];
}

/** 暂停 */
- (IBAction)pause
{
    [self.playerView pause];
}

/** 停止 */
- (IBAction)stop
{
    
}

//UISlider的响应方法:拖动滑块，改变播放进度
- (IBAction)sliderViewChange:(id)sender {
    [self.playerView aVplayerToTime:self.slider.value];
}

//转换时间格式的方法
- (NSString *)formatTimeWithTimeInterVal:(NSTimeInterval)timeInterVal{
    int minute = 0;
    int hour = 0;
    int secend = timeInterVal;
    hour = secend / 3600;
    minute = (secend % 3600) / 60;
    secend = secend % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, secend];
}



@end
