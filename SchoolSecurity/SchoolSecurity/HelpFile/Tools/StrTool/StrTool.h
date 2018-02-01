//
//  StrTool.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/18.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrTool : NSObject

/**
 * 检测身份证
 */
+(BOOL)checkUserID:(NSString *)userID;

/**
* 检测手机号
*/
+(BOOL)checkMobilePhone:(NSString *)phoneNum;

/**
* 检测车牌号
*/
+(BOOL)checkCarID:(NSString *)carID;

/**
 * 获取时间戳
 */
+ (NSString *)getTimeStamp;

/**
 * 数组转js格式
 */
+ (NSString *)arrayToJSONString:(NSArray *)array;

/**
 * 获取时间
 */
+ (NSString *)getNowTime;


@end
