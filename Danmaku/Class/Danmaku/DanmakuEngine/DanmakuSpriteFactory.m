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

+ (DanmakuSprite *)createDanmaku:(DanmakuType)type
                       viewClass:(NSString *)viewClass
                       viewModel:(id)viewModel
{
    DanmakuSprite *danmaku = [DanmakuSprite new];
    danmaku.viewClass = viewClass;
    danmaku.viewModel = viewModel;
    return danmaku;
}

@end
