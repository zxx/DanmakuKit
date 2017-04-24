//
//  DanmakuSprite.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DanmakuCanvas, DanmakuView;

@interface DanmakuSprite : NSObject

@property (nonatomic, copy) NSString *viewClass;
@property (nonatomic, strong) id viewModel;

@property (nonatomic, strong, readonly) DanmakuView *bindingView;

@property (nonatomic, assign) NSRange stripRange;

@property (nonatomic, assign) CGRect beginFrame;
@property (nonatomic, assign) CGRect endFrame;

- (void)setCompletionHandler:(void(^)(DanmakuSprite *))handler;

- (void)active;
- (void)deactive;

- (BOOL)isValid;

@end
