//
//  FKDetail+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FKDetail+CoreDataProperties.h"

@implementation FKDetail (CoreDataProperties)

+ (NSFetchRequest<FKDetail *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FKDetail"];
}

@dynamic visitor_id;
@dynamic name;
@dynamic sex;
@dynamic tel;
@dynamic id_card;
@dynamic status;
@dynamic wx_id;
@dynamic school_list;
@dynamic birthday;

@end
