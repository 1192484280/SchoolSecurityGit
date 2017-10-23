//
//  XGJL+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "XGJL+CoreDataProperties.h"

@implementation XGJL (CoreDataProperties)

+ (NSFetchRequest<XGJL *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"XGJL"];
}

@dynamic p_id;
@dynamic patrol_time;
@dynamic psr_number;
@dynamic distance;

@end
