//
//  SecuritySGAgree+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/19.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "SecuritySGAgree+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SecuritySGAgree (CoreDataProperties)

+ (NSFetchRequest<SecuritySGAgree *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id_address;
@property (nullable, nonatomic, copy) NSString *id_birthday;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *id_name;
@property (nullable, nonatomic, copy) NSString *id_nation;
@property (nullable, nonatomic, copy) NSString *id_release_organ;
@property (nullable, nonatomic, copy) NSString *id_sex;
@property (nullable, nonatomic, copy) NSString *id_validity_date;
@property (nullable, nonatomic, copy) NSString *is_car;
@property (nullable, nonatomic, copy) NSString *is_other_persion;
@property (nullable, nonatomic, copy) NSString *other_person_list;
@property (nullable, nonatomic, copy) NSString *school_id;
@property (nullable, nonatomic, copy) NSString *security_personnel_id;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *visitor_picture;
@property (nullable, nonatomic, copy) NSString *visitor_tel;
@property (nullable, nonatomic, copy) NSString *caller_id;
@property (nullable, nonatomic, copy) NSString *org_id;
@property (nullable, nonatomic, copy) NSString *timeStamp;

@end

NS_ASSUME_NONNULL_END
