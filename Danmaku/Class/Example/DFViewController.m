//
//  DFViewController.m
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DFViewController.h"
#import "Danmaku.h"

#import "MyViewModel.h"
#import "MyDanmakuView.h"

@interface DFViewController ()

@property (nonatomic, strong) DanmakuRenderer *danmakuRender;

@property (nonatomic, strong) UILabel *label;

@end

@implementation DFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    DanmakuRenderer *renderer = [[DanmakuRenderer alloc] init];
    renderer.view.frame = CGRectMake(0, 120, 375, 200);
    renderer.danmakuVerticalAlignment = DanmakuVerticalAlignmentBottom;
    renderer.danmakuMoveDirection = DanmakuMoveDirectionRightToLeft;
    [self.view addSubview:renderer.view];
    [renderer start];
    
    renderer.view.backgroundColor = [UIColor yellowColor];
    _danmakuRender = renderer;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor blueColor];
    button.frame = CGRectMake(100, 20, 80, 40);
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundColor:[UIColor greenColor]];
    [button2 setTitle:@"Block" forState:UIControlStateNormal];
    button2.titleLabel.textColor = [UIColor blueColor];
    button2.frame = CGRectMake(200, 20, 80, 40);
    [button2 addTarget:self action:@selector(blockUiThread:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(frame)];
    [dl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(375/2.0 - 60, 340, 120, 30);
    [self.view addSubview:label];
    
    _label = label;
}

- (void)frame
{
    _label.text = [NSString stringWithFormat:@"%f", CACurrentMediaTime()];
}

- (void)blockUiThread:(UIButton *)button
{
    [NSThread sleepForTimeInterval:3.0];
}

static int count = 0;
- (void)onClick:(UIButton *)button
{
    for (int i = count; i < count + 50; ++i) {
        MyViewModel *viewModel = [MyViewModel new];
        viewModel.text = @"text danmaku";
        DanmakuSprite *danmaku = [DanmakuSpriteFactory createDanmakuWithViewClass:NSStringFromClass([MyDanmakuView class])
                                                                        viewModel:viewModel];
        [self.danmakuRender accept:danmaku];
    }
    
    count += 21;
}

@end

