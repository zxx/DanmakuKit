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

- (CGRect)getBeginFrame:(DanmakuSprite *)danmaku alignment:(DanmakuAlignment)alignment
{
    CGFloat y = 0.0;
    if (alignment == DanmakuAlignmentTop) {
        y = danmaku.stripRange.location * self.stripHeight;
    } else {
        y = (danmaku.stripRange.location - danmaku.stripRange.length) * self.stripHeight;
    }
    
    CGRect frame = danmaku.bindingView.frame;
    frame.origin = CGPointMake(CGRectGetMaxX(self.bounds), y);
    return frame;
}

- (CGRect)getEndFrame:(DanmakuSprite *)danmaku alignment:(DanmakuAlignment)alignment
{
    CGFloat y = 0.0;
    if (alignment == DanmakuAlignmentTop) {
        y = danmaku.stripRange.location * self.stripHeight;
    } else {
        y = (danmaku.stripRange.location - danmaku.stripRange.length) * self.stripHeight;
    }
    
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

@implementation DanmakuCanvas (TouchEventHandler)
/*
 *              ┌────────────────────────────┐
 *              │      Point in Canvas       │
 *              │         { 20, 15 }         │
 *              └────────────────────────────┘
 *                  ▲
 *           ┌──────┼───────────────────────────┐
 *           │      │                           │
 *           │  ┌ ─ ┼ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐   │┌───────────────────────────┐
 *           │  │   ■                       │   ││   ■                       │
 *           │      │ PresentationLayer         ││   │    ModelLayer         │
 *           │  │   │                       │   ││   │                       │
 *           │   ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─    │└───┼───────────────────────┘
 *           │      │                           │    │
 *           └──────┼───────────────────────────┘    │
 *                  ▼                                ▼
 *              ┌────────────────────────────┐   ┌────────────────────────────┐
 *              │ Point in PresentationLayer │   │ Point in ModelLayer(View)  │
 *              │          { 5, 5 }          │   │          { 5, 5 }          │
 *              └────────────────────────────┘   └────────────────────────────┘
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for (DanmakuView *view in self.subviews) {
        // PresentationLayer 坐标系上的点 和 ModelLayer 坐标系上的点「值」是一样的
        CGPoint pointInDanmaku = [view.layer.presentationLayer convertPoint:point
                                                                  fromLayer:self.layer];
#ifdef DEBUG
        if ([view.layer.presentationLayer containsPoint:pointInDanmaku]) {
            NSLog(@"%@", [view.viewModel valueForKey:@"text"]);
        }
#endif
        UIView *responder = [view hitTest:pointInDanmaku withEvent:event];
        if (responder) {
            return responder;
        }
    }
    
    return [super hitTest:point withEvent:event];
}

@end
