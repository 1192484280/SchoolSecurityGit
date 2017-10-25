//
//  AllSchoolBlack+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "AllSchoolBlack+CoreDataProperties.h"

@implementation AllSchoolBlack (CoreDataProperties)

+ (NSFetchRequest<AllSchoolBlack *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AllSchoolBlack"];
}

@dynamic bl_id;
@dynamic school_id;
@dynamic name;
@dynamic id_card;
@dynamic note;

@end
