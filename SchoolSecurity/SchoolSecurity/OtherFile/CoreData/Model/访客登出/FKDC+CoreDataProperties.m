//
//  FKDC+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FKDC+CoreDataProperties.h"

@implementation FKDC (CoreDataProperties)

+ (NSFetchRequest<FKDC *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FKDC"];
}

@dynamic vr_id;
@dynamic schoolId;
@dynamic securityId;

@end
