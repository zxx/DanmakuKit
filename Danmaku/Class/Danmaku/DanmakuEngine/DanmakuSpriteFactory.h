//
//  DanmakuSpriteFactory.h
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DanmakuSprite.h"

@interface DanmakuSpriteFactory : NSObject

+ (DanmakuSprite *)createDanmakuWithViewClass:(NSString *)viewClass
                                    viewModel:(id)viewModel;

+ (DanmakuSprite *)createDanmakuWithViewClass:(NSString *)viewClass
                                    viewModel:(id)viewModel
                                        speed:(DanmakuMoveSpeed)speed;

@end
