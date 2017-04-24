//
//  DanmakuDispatcher.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DanmakuSprite;

@protocol DanmakuDispatcherDelegate <NSObject>

/**
 * Active 成功 return YES，反之 return NO
 */
- (BOOL)dispatcher:(id)dispatcher activeSprite:(DanmakuSprite *)sprite;

@end


@interface DanmakuDispatcher : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *activeSprites;
@property (nonatomic, strong, readonly) NSMutableArray *waitingSprites;
@property (nonatomic, strong, readonly) NSMutableArray *deadSprites;

@property (nonatomic, weak) id<DanmakuDispatcherDelegate> delegate;

- (void)addSprite:(DanmakuSprite *)sprite;
- (void)dispatchSprites;

@end
