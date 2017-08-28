//
//  DanmakuRenderer.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DanmakuDefines.h"

@class DanmakuSprite;

@interface DanmakuRenderer : NSObject

@property (nonatomic, assign, readonly) UIView *view;
@property (nonatomic, assign, readonly) BOOL isRunning;

@property (nonatomic, assign) DanmakuVerticalAlignment danmakuVerticalAlignment;
@property (nonatomic, assign) DanmakuMoveDirection     danmakuMoveDirection;

- (void)start;
- (void)pause;
- (void)stop;

- (void)accept:(DanmakuSprite *)danmaku;

@end
