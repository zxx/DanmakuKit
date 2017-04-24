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

@class DanmakuSprite, DanmakuDescriptor;

@interface DanmakuRenderer : NSObject

@property (nonatomic, assign, readonly) DanmakuRendererState state;

@property (nonatomic, weak, readonly) UIView *view;

/* 画布内边距 */
@property (nonatomic, assign) UIEdgeInsets canvasInset;

- (void)start;
- (void)pause;
- (void)stop;

- (void)accept:(DanmakuSprite *)danmaku;

@end
