//
//  DanmakuSprite.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DanmakuType) {
    DanmakuTypeLeftToRight,
    DanmakuTypeRightToLeft,
};

@class DanmakuCanvas, DanmakuView, DanmakuSprite;

@protocol DanmakuSpriteDeleagte <NSObject>

- (void)danmakuDidReachTheEnd:(DanmakuSprite *)danmaku;

@end

@interface DanmakuSprite : NSObject

@property (nonatomic, copy) NSString *viewClass;
@property (nonatomic, strong) id viewModel;

@property (nonatomic, strong) DanmakuView *bindingView;

@property (nonatomic, assign) NSRange stripRange;

@property (nonatomic, assign) CGSize displaySize;

@property (nonatomic, assign) CGRect beginFrame;
@property (nonatomic, assign) CGRect endFrame;

@property (nonatomic, weak) id<DanmakuSpriteDeleagte> delegate;

- (void)active;
- (void)deactive;

- (BOOL)isValid;

@end
