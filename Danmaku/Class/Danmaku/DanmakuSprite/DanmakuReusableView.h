//
//  DanmakuReusableView.h
//  Danmaku
//
//  Created by zhudf on 2017/8/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DanmakuReusableView : UIView

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

- (void)prepareForReuse;

@end
