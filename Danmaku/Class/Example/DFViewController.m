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

@end

@implementation DFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    DanmakuRenderer *renderer = [[DanmakuRenderer alloc] init];
    renderer.view.frame = CGRectMake(0, 120, 375, 200);
    renderer.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:renderer.view];
    [renderer start];
    
    _danmakuRender = renderer;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor blueColor];
    button.frame = CGRectMake(150, 20, 80, 40);
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

static int count = 0;
- (void)onClick:(UIButton *)button
{
    for (int i = count; i < count + 50; ++i) {
        
        MyViewModel *viewModel = [MyViewModel new];
        viewModel.text = [NSString stringWithFormat:@"test-%d", i];
        DanmakuSprite *danmaku = [DanmakuSpriteFactory createDanmaku:DanmakuMoveDirectionRightToLeft
                                                           viewClass:@"MyDanmakuView"
                                                           viewModel:viewModel];
        [self.danmakuRender accept:danmaku];
    }
    
    count += 21;
}

@end

