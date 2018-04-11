//
//  ViewController.m
//  MB+AFN
//
//  Created by hxm on 2018/4/11.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "Network.h"
#import "HUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [HUD initHUD];
    [[Network sharedManager] GET:@"v2/movie/top250" params:@{@"start":@"1", @"count":@"5"} successBlock:^(NSString *str, NSDictionary *dict) {
        NSLog(@"success，%@", str);
        [HUD textHUD:@"success"];
    } failureBlock:^(NSError *error) {
        [HUD textHUD:error.localizedDescription];
        NSLog(@"error:%@", error.localizedDescription);
    }];
}


@end
