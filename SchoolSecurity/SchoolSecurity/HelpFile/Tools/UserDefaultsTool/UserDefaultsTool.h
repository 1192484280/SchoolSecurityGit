//
//  UserDefaultsTool.h
//  SchoolSecurity
//
//  Created by zhangming on 17/10/12.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsTool : NSObject

/**
 * 获取学校id
 */
+ (NSString *)getSchoolId;

/**
 * 获取保安id
 */
+ (NSString *)getSecurityId;

/**
 * 添加存储数据
 */
+ (void)setObj:(NSString *)obj andKey:(NSString *)key;

/**
 * 查找存储数据
 */
+ (NSString *)getObjWithKey:(NSString *)key;

/**
 * 删除存储数据
 */
+ (void)deleteObjWithKey:(NSString *)key;

@end
