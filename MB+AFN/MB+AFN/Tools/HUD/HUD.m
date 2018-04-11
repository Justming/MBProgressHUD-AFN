//
//  HUD.m
//  YYKitDemo
//
//  Created by hxm on 2018/4/10.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "HUD.h"
#import "MBProgressHUD.h"

static MBProgressHUD *stateHud = nil;

@interface HUD ()<MBProgressHUDDelegate>

@end
@implementation HUD

+ (void)initHUD {
    
    if (!stateHud) {
        stateHud = [[MBProgressHUD alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:stateHud];
    }
    stateHud.mode = MBProgressHUDModeIndeterminate;
    stateHud.label.text = @"";
    stateHud.contentColor = [UIColor whiteColor];
    stateHud.bezelView.color = [UIColor blackColor  ];
    stateHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [stateHud showAnimated:YES];
}

+ (void)hideHUD {
    
    [stateHud hideAnimated:YES];
}

+ (void)initHUDWithText:(NSString *)text {
    if (!stateHud) {
        stateHud = [[MBProgressHUD alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:stateHud];
    }
    stateHud.mode = MBProgressHUDModeIndeterminate;
    stateHud.label.text = text;
    stateHud.contentColor = [UIColor whiteColor];
    stateHud.bezelView.color = [UIColor blackColor];
    [stateHud showAnimated:YES];
}

+ (void)textHUD:(NSString *)text {
    if (!stateHud) {
        stateHud = [[MBProgressHUD alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:stateHud];
    }
    stateHud.mode = MBProgressHUDModeText;
    stateHud.label.text = text;
    stateHud.label.font = [UIFont systemFontOfSize:15];
    stateHud.contentColor = [UIColor whiteColor];
    stateHud.bezelView.color = [UIColor blackColor];
    [stateHud showAnimated:YES];
    [stateHud hideAnimated:YES afterDelay:1.0];
    
}


@end
