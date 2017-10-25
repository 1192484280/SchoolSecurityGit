//
//  OtherPersonInfo+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "OtherPersonInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OtherPersonInfo (CoreDataProperties)

+ (NSFetchRequest<OtherPersonInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *vrop_id;
@property (nullable, nonatomic, copy) NSString *visitor_picture;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *id_name;
@property (nullable, nonatomic, copy) NSString *id_sex;
@property (nullable, nonatomic, copy) NSString *id_birthday;
@property (nullable, nonatomic, copy) NSString *id_address;
@property (nullable, nonatomic, copy) NSString *id_validity_date;
@property (nullable, nonatomic, copy) NSString *id_nation;
@property (nullable, nonatomic, copy) NSString *id_release_organ;
@property (nullable, nonatomic, copy) NSString *vr_id;

@end

NS_ASSUME_NONNULL_END
