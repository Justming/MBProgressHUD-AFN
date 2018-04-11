//
//  HUD.h
//  YYKitDemo
//
//  Created by hxm on 2018/4/10.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUD : NSObject

/**
 只显示菊花
 */
+ (void)initHUD;


/**
 隐藏
 */
+ (void)hideHUD;


/**
 显示菊花和文字

 @param text 文字
 */
+ (void)initHUDWithText:(NSString *)text;


/**
 只显示文字

 @param text 文字
 */
+ (void)textHUD:(NSString *)text;

@end
