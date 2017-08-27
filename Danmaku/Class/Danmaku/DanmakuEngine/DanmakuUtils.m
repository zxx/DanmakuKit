//
//  DanmakuUtils.m
//  Danmaku
//
//  Created by zhudf on 2017/8/27.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuUtils.h"
#import "DanmakuSprite.h"
#import "DanmakuView.h"
#import "DanmakuCanvas.h"

@implementation DanmakuUtils

+ (CGRect)getDanmakuBeginFrame:(DanmakuSprite *)danmaku
                     alignment:(DanmakuAlignment)alignment
                        canvas:(DanmakuCanvas *)canvas
{
    CGFloat y = 0.0;
    if (alignment == DanmakuAlignmentTop) {
        y = danmaku.stripRange.location * canvas.stripHeight;
    } else {
        y = (danmaku.stripRange.location - danmaku.stripRange.length) * canvas.stripHeight;
    }
    
    CGRect frame = danmaku.bindingView.frame;
    frame.origin = CGPointMake(CGRectGetMaxX(canvas.bounds), y);
    return frame;
}

+ (CGRect)getDanmakuEndFrame:(DanmakuSprite *)danmaku
                   alignment:(DanmakuAlignment)alignment
                      canvas:(DanmakuCanvas *)canvas
{
    CGFloat y = 0.0;
    if (alignment == DanmakuAlignmentTop) {
        y = danmaku.stripRange.location * canvas.stripHeight;
    } else {
        y = (danmaku.stripRange.location - danmaku.stripRange.length) * canvas.stripHeight;
    }
    
    CGRect frame = danmaku.bindingView.frame;
    frame.origin = CGPointMake(-CGRectGetWidth(frame), y);
    return frame;
}

+ (BOOL)checkIsDanmakuRightIn:(DanmakuSprite *)danmaku canvas:(DanmakuCanvas *)canvas
{
    CALayer *presentationLayer = danmaku.bindingView.layer.presentationLayer;
    if (!presentationLayer) {
        presentationLayer = danmaku.bindingView.layer.modelLayer;
    }
    
    CGFloat right = CGRectGetMaxX(presentationLayer.frame);
    return CGRectGetWidth(canvas.bounds) > right;
}

+ (BOOL)checkIsDanmakuLeftIn:(DanmakuSprite *)danmaku canvas:(DanmakuCanvas *)canvas
{
    CALayer *presentationLayer = danmaku.bindingView.layer.presentationLayer;
    if (!presentationLayer) {
        presentationLayer = danmaku.bindingView.layer.modelLayer;
    }
    
    CGFloat left = CGRectGetMinX(presentationLayer.frame);
    return left > 0;
}

@end

