//
//  AppDelegate.m
//  MB+AFN
//
//  Created by hxm on 2018/4/11.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "AppDelegate.h"
#import "Network.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[Network sharedManager] showNetworkIndicatior:YES];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"即将失去活动项");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    NSLog(@"进入后台");
    [[Network sharedManager] stopMonitoring];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    NSLog(@"即将进入前台");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"进入前台");
    [[Network sharedManager] startMonitoring];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSLog(@"程序终止");
}


@end
