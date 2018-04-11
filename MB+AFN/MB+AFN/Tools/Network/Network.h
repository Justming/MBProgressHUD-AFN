//
//  Network.h
//  YYKitDemo
//
//  Created by hxm on 2018/4/9.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface Network : AFHTTPSessionManager

+ (instancetype)sharedManager;



- (void)GET:(NSString *)URLString params:(id)params successBlock:(void (^)(NSString *str, NSDictionary *dict))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

- (void)POST:(NSString *)URLString params:(id)params successBlock:(void (^)(NSString *str, NSDictionary *dict))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

- (void)uploadTo:(NSString *)URLString data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType params:(id)params successBlock:(void (^)(NSString *str, NSDictionary *dict))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

- (void)downloadFrom:(NSString *)URLString progress:(void (^)(CGFloat progress))progressBlock completetion:(void (^)(BOOL isSuccess, NSError *error, NSURL *savePath))completetionBlock;

- (void)startMonitoring;

- (void)stopMonitoring;

- (BOOL)checkNetwork;

- (void)showNetworkIndicatior:(BOOL)enabled;

@end
