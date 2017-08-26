//
//  MyDanmakuView.m
//  Danmaku
//
//  Created by zhudf on 2017/8/24.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "MyDanmakuView.h"
#import "MyViewModel.h"

@interface MyDanmakuView()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel     *textLabel;

@end

@implementation MyDanmakuView

@synthesize viewModel=_viewModel;

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super initWithIdentifier:identifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.0
                                                           green:arc4random_uniform(100) / 100.0
                                                            blue:arc4random_uniform(100) / 100.0
                                                           alpha:1.0];
        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat midY = CGRectGetMidY(self.bounds);

    self.contentView.frame = CGRectMake(0, 2.0,
                                        CGRectGetWidth(self.bounds),
                                        CGRectGetHeight(self.bounds) - 4.0);
    self.avatarView.frame = CGRectMake(8, midY - 10, 20, 20);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarView.frame) + 8,
                                      midY - 10,
                                      CGRectGetMaxX(self.bounds) - CGRectGetMaxX(self.avatarView.frame) - 8,
                                      20);
    [self addEventListener];
}

- (void)addEventListener
{
    self.avatarView.userInteractionEnabled = YES;
    self.textLabel.userInteractionEnabled = YES;
    
    [self.avatarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)]];
    [self.textLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)]];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)]];
}

- (void)prepareForReuse
{
    
}

- (void)setViewModel:(MyViewModel *)viewModel
{
    _viewModel = viewModel;
    
    self.textLabel.text = viewModel.text;
}

- (CGSize)viewSize
{
    return self.textLabel.bounds.size;
}

+ (CGSize)viewSizeWithViewModel:(id)viewModel
{
    return CGRectMake(0,
                      0,
                      200 + arc4random_uniform(80),
                      30 + arc4random_uniform(10)).size;
}

- (void)onClick:(UITapGestureRecognizer *)gesture
{
    if (gesture.view == self.avatarView) {
        NSLog(@"Click Avatar");
    } else if (gesture.view == self.textLabel) {
        NSLog(@"Click Label: %@", self.textLabel.text);
    } else {
        NSLog(@"Click Danmaku: %@", self.textLabel.text);
    }
}

#pragma mark -

- (UIImageView *)avatarView
{
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.image = [UIImage imageNamed:@"unicorn"];
        _avatarView.layer.cornerRadius = 10;
        _avatarView.layer.masksToBounds = YES;
    }
    return _avatarView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _textLabel;
}

@end
