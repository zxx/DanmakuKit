//
//  DanmakuView.m
//  Danmaku
//
//  Created by zhudf on 2017/8/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DanmakuView.h"

@interface DanmakuView()

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation DanmakuView

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.identifier = identifier;
        
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit
{
    [self addSubview:self.contentView];
}

- (CGSize)viewSize
{
    return CGSizeZero;
}

- (CGSize)viewSizeWithViewModel:(id)viewModel
{
    return CGSizeZero;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _contentView;
}

@end
