//
//  OrgInfo+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/18.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "OrgInfo+CoreDataProperties.h"

@implementation OrgInfo (CoreDataProperties)

+ (NSFetchRequest<OrgInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OrgInfo"];
}

@dynamic name;
@dynamic org_id;

@end
