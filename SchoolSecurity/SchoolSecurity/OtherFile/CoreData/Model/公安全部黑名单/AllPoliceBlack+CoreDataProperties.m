//
//  AllPoliceBlack+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "AllPoliceBlack+CoreDataProperties.h"

@implementation AllPoliceBlack (CoreDataProperties)

+ (NSFetchRequest<AllPoliceBlack *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AllPoliceBlack"];
}

@dynamic pbl_id;
@dynamic name;
@dynamic id_card;
@dynamic note;

@end
