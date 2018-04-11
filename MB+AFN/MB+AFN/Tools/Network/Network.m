//
//  Network.m
//  YYKitDemo
//
//  Created by hxm on 2018/4/9.
//  Copyright © 2018年 Harry. All rights reserved.
//

#import "Network.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface Network ()

@end
@implementation Network


+ (instancetype)sharedManager {
    
    static Network *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"https://api.douban.com/"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        config.timeoutIntervalForRequest = 15.0f;
        
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        
        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", nil];
    });
    
    return instance;
}

- (void)GET:(NSString *)URLString params:(id)params successBlock:(void (^)(NSString *str, NSDictionary *dict))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    
    if (![self checkNetwork]) {
        NSLog(@"请检查网络连接");
        return;
    }
    
    [self GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *respDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (successBlock) {
            successBlock(string, respDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
- (void)POST:(NSString *)URLString params:(id)params successBlock:(void (^)(NSString *str, NSDictionary *dict))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    
    if (![self checkNetwork]) {
        NSLog(@"请检查网络连接");
        return;
    }
    
    [self POST:URLString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *respDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (successBlock) {
            successBlock(string, respDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

- (void)uploadTo:(NSString *)URLString data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType params:(id)params successBlock:(void (^)(NSString *str, NSDictionary *dict))successBlock failureBlock:(void (^)(NSError *error))failureBlock  {
    
    if (![self checkNetwork]) {
        NSLog(@"请检查网络连接");
        return;
    }
    
    [self POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *respDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (successBlock) {
            successBlock(string, respDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

- (void)downloadFrom:(NSString *)URLString progress:(void (^)(CGFloat progress))progressBlock completetion:(void (^)(BOOL isSuccess, NSError *error, NSURL *savePath))completetionBlock {
    
    if (![self checkNetwork]) {
        NSLog(@"请检查网络连接");
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSURLSessionDownloadTask *task = [[Network sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat currentProgress = 1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        if (progressBlock) {
            progressBlock(currentProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // targerPath 下载时自动保存的临时路径
        
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"images/%@", response.suggestedFilename]];
        
        return [NSURL fileURLWithPath:fullPath];//最终要保存的路径，由临时路径移动到当前路径
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            if (completetionBlock) {
                completetionBlock(NO, error, nil);
            }
        } else {
            if (completetionBlock) {
                completetionBlock(YES, error, filePath);
            }
        }
    }];
    
    [task resume];
}



- (void)showNetworkIndicatior:(BOOL)enabled {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:enabled];
}

- (void)startMonitoring {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"当前使用未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"当前无可用网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"当前使用WIFI网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"当前使用运营商网络");
                break;
            default:
                break;
        }
    }];

    [manager startMonitoring];
}

- (void)stopMonitoring {
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (BOOL)checkNetwork {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    if ([manager isReachable]) {
        return YES;
    }  else {
        return NO;
    }
    return NO;
}

@end
