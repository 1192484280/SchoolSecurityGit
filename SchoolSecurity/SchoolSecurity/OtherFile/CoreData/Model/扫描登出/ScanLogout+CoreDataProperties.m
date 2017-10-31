//
//  ScanLogout+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/31.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "ScanLogout+CoreDataProperties.h"

@implementation ScanLogout (CoreDataProperties)

+ (NSFetchRequest<ScanLogout *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ScanLogout"];
}

@dynamic idCard;
@dynamic securityId;

@end
