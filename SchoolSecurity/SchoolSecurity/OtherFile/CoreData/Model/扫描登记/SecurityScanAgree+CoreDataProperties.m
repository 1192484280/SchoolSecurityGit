//
//  SecurityScanAgree+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "SecurityScanAgree+CoreDataProperties.h"

@implementation SecurityScanAgree (CoreDataProperties)

+ (NSFetchRequest<SecurityScanAgree *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SecurityScanAgree"];
}

@dynamic id_address;
@dynamic id_birthday;
@dynamic id_card;
@dynamic id_name;
@dynamic id_nation;
@dynamic id_release_organ;
@dynamic id_sex;
@dynamic id_validity_date;
@dynamic is_car;
@dynamic is_other_person;
@dynamic other_person_list;
@dynamic plate_number;
@dynamic school_id;
@dynamic security_personnel_id;
@dynamic status;
@dynamic visitor_id;
@dynamic visitor_picture;
@dynamic visitor_tel;
@dynamic vr_id;

@end
