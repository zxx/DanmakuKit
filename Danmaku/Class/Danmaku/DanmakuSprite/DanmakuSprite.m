//
//  DanmakuSprite.m
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuSprite.h"
#import "DanmakuCanvas.h"
#import "DanmakuView.h"

@interface DanmakuSprite()<CAAnimationDelegate>

@end

@implementation DanmakuSprite

- (void)active:(DanmakuCanvas *)canvas
{
    [canvas draw:self];
    
    [self active];
}

- (void)active
{
    // BindingView 不能先加到 Canvas 上，不然 PresentationLayer 的初始位置就会出错。以后找原因
    self.bindingView.frame = self.beginFrame;
    
    CGFloat distance = fabs(CGRectGetMidX(self.beginFrame) - CGRectGetMidX(self.endFrame));
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.beginFrame),
                                                           CGRectGetMidY(self.beginFrame))];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.endFrame),
                                                         CGRectGetMidY(self.endFrame))];
    anim.duration = distance * 0.05;
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    
    [self.bindingView.layer addAnimation:anim forKey:@"run"];
    
#ifndef DEBUG
    if (self.bindingView.layer.presentationLayer) {
        NSLog(@"Presentation: %@, %@", self.bindingView.layer.presentationLayer, NSStringFromCGRect(self.bindingView.layer.presentationLayer.frame));
    }
    NSLog(@"Model: %@, %@", self.bindingView.layer.modelLayer, NSStringFromCGRect(self.bindingView.layer.modelLayer.frame));
    NSLog(@"begin: %@， end:%@", NSStringFromCGRect(self.beginFrame), NSStringFromCGRect(self.endFrame));
#endif
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self deactive];
    
    if ([self.delegate respondsToSelector:@selector(danmakuDidReachTheEnd:)]) {
        [self.delegate danmakuDidReachTheEnd:self];
    }
}

- (void)deactive
{
    [self.bindingView removeFromSuperview];
}

- (void)setStripRange:(NSRange)stripRange
{
    if (NSEqualRanges(_stripRange, stripRange)) {
        return;
    }
    
    _stripRange = stripRange;
    
    [_viewModel setValue:[NSString stringWithFormat:@"%@ %@",
                          [_viewModel valueForKey:@"text"],
                          NSStringFromRange(stripRange)]
                  forKey:@"text"];
    self.bindingView.viewModel = _viewModel;
}

- (CGSize)displaySize
{
    if (CGSizeEqualToSize(_displaySize, CGSizeZero)) {
        _displaySize = [NSClassFromString(self.viewClass) viewSizeWithViewModel:self.viewModel];
        // _displaySize = [self.bindingView viewSize];
    }
    return _displaySize;
}

- (DanmakuView *)bindingView
{
    if (!_bindingView) {
        Class cls = NSClassFromString(self.viewClass);
        if (!cls) {
            @throw [NSException exceptionWithName:@"InvalidArgumentException"
                                           reason:@"Danmaku view class not exists"
                                         userInfo:nil];
        }
        _bindingView = [[cls alloc] initWithIdentifier:nil];
        _bindingView.clipsToBounds = YES;
        _bindingView.viewModel = self.viewModel;
        _bindingView.bounds = (CGRect){CGPointZero, self.displaySize };
    }
    return _bindingView;
}

- (BOOL)isValid
{
    // Check ...
    return YES;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<DanmakuSprite: %@>", NSStringFromRange(_stripRange)];
}

@end
