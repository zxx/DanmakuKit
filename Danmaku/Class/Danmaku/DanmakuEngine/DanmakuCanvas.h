//
//  DanmakuCanvas.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DanmakuDefines.h"

@class DanmakuSprite;

@interface DanmakuCanvas : UIView

@property (nonatomic, assign, readonly) CGFloat stripNumber;
@property (nonatomic, assign, readonly) CGFloat stripHeight;

- (void)draw:(DanmakuSprite *)sprite;


@end
