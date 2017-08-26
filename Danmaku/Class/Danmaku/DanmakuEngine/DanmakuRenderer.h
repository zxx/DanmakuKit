//
//  DanmakuRenderer.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DanmakuRendererState) {
    DanmakuRendererStateIdle,
    DanmakuRendererStateStarted,
    DanmakuRendererStatePaused,
    DanmakuRendererStateStopped
};

typedef NS_ENUM(NSInteger, DanmakuAlignment) {
    DanmakuAlignmentTop,
    DanmakuAlignmentBottom,
};

@class DanmakuSprite;

@interface DanmakuRenderer : NSObject

@property (nonatomic, assign, readonly) DanmakuRendererState state;
@property (nonatomic, assign, readonly) UIView *view;

@property (nonatomic, assign) DanmakuAlignment danmakuAlignment;

- (void)start;
- (void)pause;
- (void)stop;

- (void)accept:(DanmakuSprite *)danmaku;

@end
