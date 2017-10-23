//
//  SecuritySGAgree+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "SecuritySGAgree+CoreDataProperties.h"

@implementation SecuritySGAgree (CoreDataProperties)

+ (NSFetchRequest<SecuritySGAgree *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SecuritySGAgree"];
}

@dynamic caller_id;
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
@dynamic org_id;
@dynamic other_person_list;
@dynamic school_id;
@dynamic security_personnel_id;
@dynamic status;
@dynamic timeStamp;
@dynamic visitor_picture;
@dynamic visitor_tel;
@dynamic plate_number;

@end
