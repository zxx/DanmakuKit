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
