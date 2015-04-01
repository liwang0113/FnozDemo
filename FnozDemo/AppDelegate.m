//
//  AppDelegate.m
//  FnozDemo
//
//  Created by Fnoz on 15/3/20.
//  Copyright (c) 2015年 Fnoz. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FnozNaviViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MainViewController *vc = [[MainViewController alloc] init];
    FnozNaviViewController *nav = [[FnozNaviViewController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nav];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
