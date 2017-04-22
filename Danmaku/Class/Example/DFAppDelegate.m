//
//  DFAppDelegate.m
//  Danmaku
//
//  Created by zhudf on 2017/4/22.
//  Copyright © 2017年 lostu.com. All rights reserved.
//

#import "DFAppDelegate.h"
#import "DFViewController.h"

@implementation DFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [DFViewController new];
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
