//
//  CallerInfo+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/18.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "CallerInfo+CoreDataProperties.h"

@implementation CallerInfo (CoreDataProperties)

+ (NSFetchRequest<CallerInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CallerInfo"];
}

@dynamic caller_id;
@dynamic mphone;
@dynamic name;
@dynamic org_id;
@dynamic school_id;
@dynamic tel;

@end
