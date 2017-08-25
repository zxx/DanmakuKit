//
//  DanmakuCanvas.m
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuCanvas.h"
#import "DanmakuSprite.h"
#import "DanmakuView.h"

#define STRIP_NUM 100

@implementation DanmakuCanvas

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _stripNumber = STRIP_NUM;
    _stripHeight = CGRectGetHeight(self.bounds) / STRIP_NUM;
}

- (void)draw:(DanmakuSprite *)sprite
{
    [self addSubview:sprite.bindingView];
    
    [sprite active];
}

- (CGRect)getBeginFrame:(DanmakuSprite *)danmaku
{
    CGFloat x = CGRectGetMaxX(self.bounds);
    CGFloat y = danmaku.stripRange.location * self.stripHeight;
    
    CGRect frame = danmaku.bindingView.frame;
    frame.origin = CGPointMake(x, y);
    return frame;
}

- (CGRect)getEndFrame:(DanmakuSprite *)danmaku
{
    CGFloat y = danmaku.stripRange.location * self.stripHeight;
    
    CGRect frame = danmaku.bindingView.frame;
    frame.origin = CGPointMake(-CGRectGetWidth(frame), y);
    return frame;
}

- (BOOL)checkIsRightIn:(DanmakuSprite *)danmaku
{
    CALayer *presentationLayer = danmaku.bindingView.layer.presentationLayer;
    if (!presentationLayer) {
        presentationLayer = danmaku.bindingView.layer.modelLayer;
    }
    
    CGFloat right = CGRectGetMaxX(presentationLayer.frame);
    return CGRectGetWidth(self.bounds) > right;
}

- (BOOL)checkIsLeftIn:(DanmakuSprite *)danmaku
{
    CALayer *presentationLayer = danmaku.bindingView.layer.presentationLayer;
    if (!presentationLayer) {
        presentationLayer = danmaku.bindingView.layer.modelLayer;
    }
    
    CGFloat left = CGRectGetMinX(presentationLayer.frame);
    return left > 0;
}

@end
