//
//  LFDetail+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "LFDetail+CoreDataProperties.h"

@implementation LFDetail (CoreDataProperties)

+ (NSFetchRequest<LFDetail *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LFDetail"];
}

@dynamic format_visitor_time;
@dynamic vr_id;
@dynamic visitor_id;
@dynamic caller_id;
@dynamic is_car;
@dynamic plate_number;
@dynamic is_other_person;
@dynamic note;
@dynamic visitor_status;
@dynamic caller_name;
@dynamic caller_mphone;
@dynamic caller_tel;
@dynamic org_name;
@dynamic school_name;
@dynamic visitor_name;
@dynamic visitor_tel;
@dynamic visitor_id_card;
@dynamic visitor_picture;

@end
