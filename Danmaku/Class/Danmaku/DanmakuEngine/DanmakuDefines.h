//
//  DanmakuDefines.h
//  Danmaku
//
//  Created by zhudf on 2017/8/23.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanmakuDefines : NSObject

@end


typedef NS_ENUM(NSInteger, DanmakuType) {
    DanmakuTypeLeftToRight,
    DanmakuTypeRightToLeft,
};

typedef NS_ENUM(NSInteger, DanmakuAlignment) {
    DanmakuAlignmentTop,
    DanmakuAlignmentBottom,
};
