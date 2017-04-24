//
//  DanmakuRenderer.m
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuRenderer.h"
#import "DanmakuDispatcher.h"
#import "DanmakuCanvas.h"
#import "DanmakuTimer.h"

#import "DanmakuSprite.h"
#import "DanmakuView.h"

@interface DanmakuRenderer()<DanmakuDispatcherDelegate, DanmakuTimerDelegate>

@property (nonatomic, strong) DanmakuCanvas     *canvas;
@property (nonatomic, strong) DanmakuDispatcher *dispatcher;
@property (nonatomic, strong) DanmakuTimer      *clock;

@property (nonatomic, assign) DanmakuRendererState state;

@property (nonatomic, strong) NSMutableSet *viewCache;

/* { stripIndex: sprite.stripRange.location } */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, DanmakuSprite *> *stripToSprite;

@end

@implementation DanmakuRenderer

- (instancetype)init
{
    if (self = [super init]) {
        _canvas = [DanmakuCanvas new];
        _dispatcher = [DanmakuDispatcher new];
        _dispatcher.delegate = self;
        
        _clock = [DanmakuTimer new];
        _clock.delegate = self;
        
        _viewCache = [NSMutableSet set];
        _stripToSprite = @{}.mutableCopy;
    }
    return self;
}

#pragma mark -

- (void)start
{
    [self.clock start];
}

- (void)pause
{
    [self.clock stop];
}

- (void)stop
{
    [self.clock stop];
}

- (void)accept:(DanmakuSprite *)danmaku
{
    if (!danmaku.isValid) return;
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self accept:danmaku];
        });
        return;
    }
    
    [self.dispatcher addSprite:danmaku];
}

#pragma mark - DanmakuTimerDelegate

- (void)DanmakuTimerDidChange:(id)clock
{
    if (self.dispatcher) {
        [self.dispatcher dispatchSprites];
    }
}

#pragma mark - DanmakuDispatcherDelegate

- (BOOL)dispatcher:(id)dispatcher activeSprite:(DanmakuSprite *)sprite
{
    return [self activeSprite:sprite];
}

/**
 * 如果 return YES，则在 WaitingList 中移除这个 Sprite
 * 相反 return NO， 则让这个 Sprite 继续保留在 WaitingList 中
 */
- (BOOL)activeSprite:(DanmakuSprite *)sprite
{
    [self.canvas addSubview:sprite.bindingView];
    NSRange range = [self getSpriteStripRange:sprite];
    if (range.location == NSNotFound) {
        [sprite.bindingView removeFromSuperview];
        return NO;
    }
    
    sprite.stripRange = range;
    sprite.beginFrame = [self.canvas getBeginFrame:sprite];
    sprite.endFrame = [self.canvas getEndFrame:sprite];
    
    [sprite setCompletionHandler:^(DanmakuSprite *sprite) {
        NSNumber *key = @(sprite.stripRange.location);
        if (self.stripToSprite[key] && [self.stripToSprite[key] isEqual:sprite]) {
            [self.stripToSprite removeObjectForKey:key];
        }
    }];
    [sprite active];
    return YES;
}

/**
 * 计算 Sprite 位置
 */
- (NSRange)getSpriteStripRange:(DanmakuSprite *)sprite
{
    // 1. 基本 Strip 信息（StripNumber, StripHeight)
    CGFloat stripHeight = self.canvas.stripHeight;
    // 2. 计算 Sprite 所需的 StipNumber
    CGFloat stripNumber = CGRectGetHeight(sprite.bindingView.bounds) / stripHeight;
    
    // 3. 遍历所有 Strip
    NSRange stripRange = NSMakeRange(NSNotFound, 0);
    NSUInteger i = 0;
    while (i < self.canvas.stripNumber) {
        NSNumber *key = @(i);
        // 只判断当前 Strip 里最后一个 Sprite 的位置
        DanmakuSprite *lastSprite = self.stripToSprite[key];
        
        // 如果当前 Strip 不可用，直接跳到 i + sprite.stripRange.length 处
        if (lastSprite && ![self.canvas checkIsRightIn:lastSprite]) {
            i += MAX(lastSprite.stripRange.length, 1);
            
            stripRange.location = NSNotFound;
            continue;
        }
        
        if (stripRange.location == NSNotFound) {
            stripRange.location = i;
            stripRange.length = 0;
        } else {
            stripRange.length++;
        }
        
        if (stripRange.length >= stripNumber) {
            sprite.stripRange = stripRange;
            // 放到 location 集合中
            self.stripToSprite[@(stripRange.location)] = sprite;
            break;
        }
        
        i += 1;
    }
    
    if (stripRange.length < stripNumber) {
        stripRange.location = NSNotFound;
    }
    
    NSLog(@"%@", NSStringFromRange(stripRange));
    return stripRange;
}

#pragma mark -

- (UIView *)view
{
    return _canvas;
}

@end
