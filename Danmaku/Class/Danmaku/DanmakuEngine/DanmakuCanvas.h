//
//  DanmakuCanvas.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DanmakuSprite;

@interface DanmakuCanvas : UIView

@property (nonatomic, assign) CGFloat stripNumber;
@property (nonatomic, assign) CGFloat stripHeight;

@property (nonatomic, assign) CGFloat minItemSpacing;
@property (nonatomic, assign) CGFloat minLineSpacing;

- (CGRect)getBeginFrame:(DanmakuSprite *)danmaku;
- (CGRect)getEndFrame:(DanmakuSprite *)danmaku;

- (BOOL)checkIsRightIn:(DanmakuSprite *)danmaku;
- (BOOL)checkIsLeftIn:(DanmakuSprite *)danmaku;

- (void)draw:(DanmakuSprite *)sprite;

@end
