//
//  HttpTool.m
//  ZENWork
//
//  Created by zhangming on 17/4/13.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "HttpTool.h"
#import "AFHTTPSessionManager.h"

@implementation HttpTool

+ (void)getUrlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 15.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            success(responseDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (NSError *)inspectError:(NSDictionary *)responseObject {
    if ([responseObject[@"status"] integerValue] == 200) {
        return nil;
    } else {
        NSError *error = [NSError errorWithDomain:ResponseFailureDomain code:[responseObject[@"result"] integerValue] userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"], NSLocalizedFailureReasonErrorKey:responseObject[@"msg"]}];
        return error;
    }
}


#pragma mark - 解析错误信息
+ (NSString *)handleError:(NSError *)error {
    if ([[error domain] isEqualToString:ResponseFailureDomain]) {
        
        return [error localizedDescription];
        
    } else {
        
        return @"网络错误，请检查您的网络配置";
    }
}


+(void)netWorkState:(void(^)(NSInteger status))block{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        block(status);
    }];
}
@end
