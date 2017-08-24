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

//@property (nonatomic, strong) DanmakuView *bindingView;

@property (nonatomic, copy) void(^completionHandler)(DanmakuSprite *);

@end

@implementation DanmakuSprite

- (void)active
{
    self.bindingView.frame = self.beginFrame;
    
    CGFloat distance = fabs(CGRectGetMidX(self.beginFrame) - CGRectGetMidX(self.endFrame));
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.beginFrame),
                                                           CGRectGetMidY(self.beginFrame))];
    anim.byValue = [NSValue valueWithCGPoint:CGPointMake(-distance, 0)];
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.endFrame),
//                                                         CGRectGetMidY(self.endFrame))];
    anim.duration = distance * 0.05;
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    
    [self.bindingView.layer addAnimation:anim forKey:@"run"];
    
    if (self.bindingView.layer.presentationLayer) {
        NSLog(@"Presentation: %@, %@", self.bindingView.layer.presentationLayer, NSStringFromCGRect(self.bindingView.layer.presentationLayer.frame));
    }
    NSLog(@"Model: %@, %@", self.bindingView.layer.modelLayer, NSStringFromCGRect(self.bindingView.layer.modelLayer.frame));
    NSLog(@"begin: %@， end:%@", NSStringFromCGRect(self.beginFrame), NSStringFromCGRect(self.endFrame));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self deactive];
    NSLog(@"stop: %@", self);
    
    if (self.completionHandler) {
        self.completionHandler(self);
    }
}

- (void)deactive
{
    [self.bindingView removeFromSuperview];
}

- (void)setStripRange:(NSRange)stripRange
{
    _stripRange = stripRange;
    
    [_viewModel setValue:[NSString stringWithFormat:@"%@ %@",
                          [_viewModel valueForKey:@"text"],
                          NSStringFromRange(stripRange)]
                  forKey:@"text"];
    self.bindingView.viewModel = _viewModel;
}

- (void)setCompletionHandler:(void (^)(DanmakuSprite *))handler
{
    _completionHandler = handler;
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
        _bindingView.viewModel = self.viewModel;
        _bindingView.bounds = (CGRect){CGPointZero, _bindingView.viewSize };
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
