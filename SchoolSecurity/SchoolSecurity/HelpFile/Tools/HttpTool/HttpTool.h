//
//  HttpTool.h
//  ZENWork
//
//  Created by zhangming on 17/4/13.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+ (void)getUrlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 * 获取error
 */
+ (NSError *)inspectError:(NSDictionary *)responseObject;

/**
 * 返回错误信息
 */
+ (NSString *)handleError:(NSError *)error;

/**
 * 检测网络状态
 */
+(void)netWorkState:(void(^)(NSInteger status))block;


@end
