//
//  SecurityScanAgree+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "SecurityScanAgree+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SecurityScanAgree (CoreDataProperties)

+ (NSFetchRequest<SecurityScanAgree *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id_address;
@property (nullable, nonatomic, copy) NSString *id_birthday;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *id_name;
@property (nullable, nonatomic, copy) NSString *id_nation;
@property (nullable, nonatomic, copy) NSString *id_release_organ;
@property (nullable, nonatomic, copy) NSString *id_sex;
@property (nullable, nonatomic, copy) NSString *id_validity_date;
@property (nullable, nonatomic, copy) NSString *is_car;
@property (nullable, nonatomic, copy) NSString *is_other_person;
@property (nullable, nonatomic, copy) NSString *other_person_list;
@property (nullable, nonatomic, copy) NSString *plate_number;
@property (nullable, nonatomic, copy) NSString *school_id;
@property (nullable, nonatomic, copy) NSString *security_personnel_id;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *visitor_id;
@property (nullable, nonatomic, copy) NSString *visitor_picture;
@property (nullable, nonatomic, copy) NSString *visitor_tel;
@property (nullable, nonatomic, copy) NSString *vr_id;

@end

NS_ASSUME_NONNULL_END
