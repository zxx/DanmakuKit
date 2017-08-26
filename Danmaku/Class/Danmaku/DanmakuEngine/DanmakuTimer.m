//
//  DanmakuTimer.m
//  Danmaku
//
//  Created by zhudf on 2017/8/23.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuTimer.h"

@interface DanmakuTimer()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DanmakuTimer

- (void)start
{
    [self stop];
    
    __weak __typeof (self) weakSelf = self;
    _timer = [NSTimer timerWithTimeInterval:1.0
                                     target:weakSelf
                                   selector:@selector(tick:)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)pause
{
    [self stop];
}

- (void)stop
{
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (void)tick:(NSTimer *)timer
{
    if ([self.delegate respondsToSelector:@selector(danmakuTimerDidChange:)]) {
        [self.delegate danmakuTimerDidChange:self];
    }
}

@end
