//
//  LFDetail+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "LFDetail+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LFDetail (CoreDataProperties)

+ (NSFetchRequest<LFDetail *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *format_visitor_time;
@property (nullable, nonatomic, copy) NSString *vr_id;
@property (nullable, nonatomic, copy) NSString *visitor_id;
@property (nullable, nonatomic, copy) NSString *caller_id;
@property (nullable, nonatomic, copy) NSString *is_car;
@property (nullable, nonatomic, copy) NSString *plate_number;
@property (nullable, nonatomic, copy) NSString *is_other_person;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *visitor_status;
@property (nullable, nonatomic, copy) NSString *caller_name;
@property (nullable, nonatomic, copy) NSString *caller_mphone;
@property (nullable, nonatomic, copy) NSString *caller_tel;
@property (nullable, nonatomic, copy) NSString *org_name;
@property (nullable, nonatomic, copy) NSString *school_name;
@property (nullable, nonatomic, copy) NSString *visitor_name;
@property (nullable, nonatomic, copy) NSString *visitor_tel;
@property (nullable, nonatomic, copy) NSString *visitor_id_card;
@property (nullable, nonatomic, copy) NSString *visitor_picture;

@end

NS_ASSUME_NONNULL_END
