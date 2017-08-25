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

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation MyDanmakuView

@synthesize viewModel=_viewModel;

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super initWithIdentifier:identifier];
    if (self) {
        [self.contentView addSubview:self.textLabel];
    }
    return self;
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
    return CGRectMake(0, 0, arc4random_uniform(100) +  200, 20 + arc4random_uniform(10)).size;
}

#pragma mark -

- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, arc4random_uniform(100) +  200, 20 + arc4random_uniform(10))];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        textLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.0
                                                    green:arc4random_uniform(100) / 100.0
                                                     blue:arc4random_uniform(100) / 100.0
                                                    alpha:1.0];
        _textLabel = textLabel;
    }
    return _textLabel;
}

@end
