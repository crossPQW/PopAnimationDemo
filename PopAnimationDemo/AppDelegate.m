//
//  AppDelegate.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/13.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "AppDelegate.h"
#import "SHListViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SHListViewController *listVc   = [[SHListViewController alloc] init];
    UINavigationController *nav    = [[UINavigationController alloc] initWithRootViewController:listVc];
    self.window.rootViewController = nav;
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.tintColor          = [UIColor colorWithRed:170/255.f green:70/255.0f blue:48/255.0f alpha:1.f];
    
    [self.window makeKeyAndVisible];
        
    return YES;
}

@end
