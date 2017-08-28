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

- (void)active
{
    self.bindingView.frame = self.beginFrame;
    
    CGFloat distance = fabs(CGRectGetMidX(self.beginFrame) - CGRectGetMidX(self.endFrame));
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.beginFrame),
                                                           CGRectGetMidY(self.beginFrame))];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.endFrame),
                                                         CGRectGetMidY(self.endFrame))];
    anim.duration = distance * _speed * 0.01;
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    
    [self.bindingView.layer addAnimation:anim forKey:@"run"];
}

- (void)deactive
{
    [self.bindingView removeFromSuperview];
}

- (CGSize)displaySize
{
    if (CGSizeEqualToSize(_displaySize, CGSizeZero)) {
        _displaySize = [NSClassFromString(self.viewClass) viewSizeWithViewModel:self.viewModel];
    }
    return _displaySize;
}

- (BOOL)isValid
{
    return _viewModel && _viewClass && NSClassFromString(_viewClass);
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self deactive];
    
    if ([self.delegate respondsToSelector:@selector(danmakuDidReachTheEnd:)]) {
        [self.delegate danmakuDidReachTheEnd:self];
    }
}

#pragma mark -

- (DanmakuView *)bindingView
{
    if (!_bindingView) {
        _bindingView = [[NSClassFromString(self.viewClass) alloc] initWithIdentifier:nil];
        _bindingView.viewModel = self.viewModel;
        _bindingView.bounds = (CGRect){CGPointZero, self.displaySize };
    }
    return _bindingView;
}

@end
