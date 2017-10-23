//
//  LFManager+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "LFManager+CoreDataProperties.h"

@implementation LFManager (CoreDataProperties)

+ (NSFetchRequest<LFManager *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LFManager"];
}

@dynamic format_visitor_time;
@dynamic note;
@dynamic status;
@dynamic vr_id;
@dynamic visitor_name;
@dynamic visitor_tel;
@dynamic caller_name;
@dynamic caller_tel;

@end
