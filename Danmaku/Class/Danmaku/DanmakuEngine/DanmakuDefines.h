//
//  DanmakuDefines.h
//  Danmaku
//
//  Created by zhudf on 2017/8/28.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#define STRIP_NUM 100


typedef NS_ENUM(NSInteger, DanmakuVerticalAlignment) {
    DanmakuVerticalAlignmentTop,
    DanmakuVerticalAlignmentBottom,
};


typedef NS_ENUM(NSInteger, DanmakuMoveDirection) {
    DanmakuMoveDirectionLeftToRight,
    DanmakuMoveDirectionRightToLeft,
};


typedef NS_ENUM(NSInteger, DanmakuMoveSpeed) {
    DanmakuMoveSpeedSlow    = 2,
    DanmakuMoveSpeedMedium  = 5,
    DanmakuMoveSpeedFast    = 10,
};


@interface DanmakuDefines : NSObject

@end
