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

@interface DanmakuRenderer()<DanmakuDispatcherDelegate, DanmakuTimerDelegate, DanmakuSpriteDeleagte>

@property (nonatomic, strong) DanmakuDispatcher *dispatcher;
@property (nonatomic, strong) DanmakuCanvas     *canvas;
@property (nonatomic, strong) DanmakuTimer      *timer;

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
        
        _timer = [DanmakuTimer new];
        _timer.delegate = self;
        
        _viewCache = [NSMutableSet set];
        _stripToSprite = @{}.mutableCopy;
    }
    return self;
}

#pragma mark -

- (void)start
{
    [self.timer start];
}

- (void)pause
{
    [self.timer stop];
}

- (void)stop
{
    [self.timer stop];
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

- (void)danmakuTimerDidChange:(id)timer
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

#pragma mark - DanmakSpriteDelegate

- (void)danmakuDidReachTheEnd:(DanmakuSprite *)sprite
{
    NSNumber *key = @(sprite.stripRange.location);
    if (self.stripToSprite[key] && [self.stripToSprite[key] isEqual:sprite]) {
        [self.stripToSprite removeObjectForKey:key];
    }
}

#pragma mark - 

/**
 * 如果 return YES，则在 WaitingList 中移除这个 Sprite
 * 相反 return NO， 则让这个 Sprite 继续保留在 WaitingList 中
 */
- (BOOL)activeSprite:(DanmakuSprite *)sprite
{
    NSRange range = [self getSpriteStripRange:sprite];
    if (range.location == NSNotFound) {
        return NO;
    }
    
    sprite.stripRange = range;
    sprite.beginFrame = [self.canvas getBeginFrame:sprite];
    sprite.endFrame = [self.canvas getEndFrame:sprite];
    sprite.delegate = self;
    [self.canvas draw:sprite];
    return YES;
}

/**
 * 计算 Sprite 位置
 */
static NSRange _lastRange;
- (NSRange)getSpriteStripRange:(DanmakuSprite *)sprite
{
    CGFloat needStripNumber = sprite.displaySize.height / self.canvas.stripHeight;
    
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
            stripRange.length = 1;
        } else {
            stripRange.length++;
        }
        
        if (stripRange.length >= needStripNumber) {
            if (stripRange.location == _lastRange.location) {
                DanmakuSprite *s = self.stripToSprite[@(stripRange.location)];
                BOOL isRightIn = [self.canvas checkIsRightIn:s];
                NSLog(@"重合: %@", isRightIn ? @"YES":@"NO");
            }
            
            sprite.stripRange = stripRange;
            self.stripToSprite[@(stripRange.location)] = sprite;
            
            _lastRange= stripRange;
            
            NSLog(@"%@", [sprite.viewModel valueForKey:@"text"]);
            break;
        }
        
        i += 1;
    }
    
    if (stripRange.length < needStripNumber) {
        stripRange.location = NSNotFound;
    }
    
    return stripRange;
}

#pragma mark -

- (UIView *)view
{
    return _canvas;
}

@end
