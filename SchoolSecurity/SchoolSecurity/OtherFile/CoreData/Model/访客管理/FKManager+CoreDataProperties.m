//
//  FKManager+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FKManager+CoreDataProperties.h"

@implementation FKManager (CoreDataProperties)

+ (NSFetchRequest<FKManager *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FKManager"];
}

@dynamic id_name;
@dynamic visitor_tel;
@dynamic visitor_time;
@dynamic visits_number;
@dynamic id_card;
@dynamic visitor_id;

@end
