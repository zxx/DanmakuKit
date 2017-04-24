//
//  DanmakuSpriteFactory.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DanmakuDefines.h"

@class DanmakuSprite, DanmakuDescriptor;

@interface DanmakuSpriteFactory : NSObject

+ (DanmakuSprite *)createDanmaku:(DanmakuType)type
                       viewClass:(NSString *)viewClass
                       viewModel:(id)viewModel;

@end
