//
//  UserDefaultsTool.m
//  SchoolSecurity
//
//  Created by zhangming on 17/10/12.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "UserDefaultsTool.h"

@implementation UserDefaultsTool

#pragma mark - 获取学校id
+ (NSString *)getSchoolId{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"school_id"];
}

#pragma mark - 获取保安id
+ (NSString *)getSecurityId{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"security_personnel_id"];
}

#pragma mark - 添加存储数据
+ (void)setObj:(NSString *)obj andKey:(NSString *)key{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:obj forKey:key];
    [ud synchronize];
    
}

#pragma mark - 查找存储数据
+ (NSString *)getObjWithKey:(NSString *)key{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *str = [ud objectForKey:key];
    return str;
}

#pragma mark - 删除存储数据
+ (void)deleteObjWithKey:(NSString *)key{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:key];
    [ud synchronize];
}

@end
