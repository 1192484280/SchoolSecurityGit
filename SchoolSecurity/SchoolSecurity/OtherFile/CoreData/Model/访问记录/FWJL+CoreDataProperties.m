//
//  FWJL+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FWJL+CoreDataProperties.h"

@implementation FWJL (CoreDataProperties)

+ (NSFetchRequest<FWJL *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FWJL"];
}

@dynamic caller_name;
@dynamic caller_tel;
@dynamic format_visitor_time;
@dynamic note;
@dynamic status;
@dynamic visitor_name;
@dynamic visitor_tel;
@dynamic vr_id;
@dynamic visitor_id;

@end
