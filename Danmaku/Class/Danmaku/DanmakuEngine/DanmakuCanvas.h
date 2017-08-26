//
//  DanmakuCanvas.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DanmakuRenderer.h"

@class DanmakuSprite;

@interface DanmakuCanvas : UIView

@property (nonatomic, assign) CGFloat stripNumber;
@property (nonatomic, assign) CGFloat stripHeight;

@property (nonatomic, assign) CGFloat minItemSpacing;
@property (nonatomic, assign) CGFloat minLineSpacing;

- (void)draw:(DanmakuSprite *)sprite;

- (CGRect)getBeginFrame:(DanmakuSprite *)danmaku alignment:(DanmakuAlignment)alignment;
- (CGRect)getEndFrame:(DanmakuSprite *)danmaku alignment:(DanmakuAlignment)alignment;

- (BOOL)checkIsRightIn:(DanmakuSprite *)danmaku;
- (BOOL)checkIsLeftIn:(DanmakuSprite *)danmaku;

@end
