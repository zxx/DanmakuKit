//
//  DanmakuTimer.h
//  Danmaku
//
//  Created by zhudf on 2017/8/23.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DanmakuTimer;

@protocol DanmakuTimerDelegate <NSObject>

- (void)DanmakuTimerDidChange:(DanmakuTimer *)clock;

@end


/**
 * NSTimer 实现的， NSTimer 依赖 RunLoop，GCD
 * 实现方式可以参考：https://github.com/ibireme/YYKit/blob/master/YYKit/Utility/YYTimer.m
 */
@interface DanmakuTimer : NSObject

@property (nonatomic, weak) id<DanmakuTimerDelegate> delegate;

- (void)start;
- (void)stop;

@end
