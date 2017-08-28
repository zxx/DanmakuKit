//
//  DanmakuSpriteFactory.m
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuSpriteFactory.h"
#import "DanmakuSprite.h"

@implementation DanmakuSpriteFactory

+ (DanmakuSprite *)createDanmaku:(DanmakuMoveDirection)type
                       viewClass:(NSString *)viewClass
                       viewModel:(id)viewModel
{
    return [self createDanmaku:type viewClass:viewClass viewModel:viewModel speed:DanmakuMoveSpeedMedium];
}


+ (DanmakuSprite *)createDanmaku:(DanmakuMoveDirection)type
                       viewClass:(NSString *)viewClass
                       viewModel:(id)viewModel
                           speed:(DanmakuMoveSpeed)speed
{
    DanmakuSprite *danmaku = [DanmakuSprite new];
    danmaku.viewClass = viewClass;
    danmaku.viewModel = viewModel;
    danmaku.speed = speed;
    return danmaku;
}

@end
