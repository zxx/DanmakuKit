//
//  DanmakuUtils.h
//  Danmaku
//
//  Created by zhudf on 2017/8/27.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DanmakuCanvas.h"

@class DanmakuCanvas, DanmakuSprite;

@interface DanmakuUtils : NSObject

+ (CGRect)getDanmakuBeginFrame:(DanmakuSprite *)danmaku
                     alignment:(DanmakuAlignment)alignment
                        canvas:(DanmakuCanvas *)canvas;
+ (CGRect)getDanmakuEndFrame:(DanmakuSprite *)danmaku
                   alignment:(DanmakuAlignment)alignment
                      canvas:(DanmakuCanvas *)canvas;

+ (BOOL)checkIsDanmakuRightIn:(DanmakuSprite *)danmaku canvas:(DanmakuCanvas *)canvas;
+ (BOOL)checkIsDanmakuLeftIn:(DanmakuSprite *)danmaku canvas:(DanmakuCanvas *)canvas;

@end
