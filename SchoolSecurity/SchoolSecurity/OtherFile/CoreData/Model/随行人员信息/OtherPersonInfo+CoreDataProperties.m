//
//  OtherPersonInfo+CoreDataProperties.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "OtherPersonInfo+CoreDataProperties.h"

@implementation OtherPersonInfo (CoreDataProperties)

+ (NSFetchRequest<OtherPersonInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OtherPersonInfo"];
}

@dynamic vrop_id;
@dynamic visitor_picture;
@dynamic id_card;
@dynamic id_name;
@dynamic id_sex;
@dynamic id_birthday;
@dynamic id_address;
@dynamic id_validity_date;
@dynamic id_nation;
@dynamic id_release_organ;
@dynamic vr_id;

@end
