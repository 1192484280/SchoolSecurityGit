//
//  XGDetail+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "XGDetail+CoreDataProperties.h"

@implementation XGDetail (CoreDataProperties)

+ (NSFetchRequest<XGDetail *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"XGDetail"];
}

@dynamic distance;
@dynamic headimg;
@dynamic line;
@dynamic p_id;
@dynamic patrol_add_time;
@dynamic patrol_end_time;
@dynamic psr_info;
@dynamic security_personnel_id;
@dynamic sp_name;

@end
