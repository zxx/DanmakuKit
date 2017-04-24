//
//  DanmakuView.h
//  Danmaku
//
//  Created by zhudf on 2017/8/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuReusableView.h"

@interface DanmakuView : DanmakuReusableView

@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, strong) id viewModel;


- (instancetype)initWithIdentifier:(NSString *)identifier;

- (CGSize)viewSize;
- (CGSize)viewSizeWithViewModel:(id)viewModel;

@end
