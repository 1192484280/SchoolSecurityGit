//
//  FWJL+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FWJL+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FWJL (CoreDataProperties)

+ (NSFetchRequest<FWJL *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *caller_name;
@property (nullable, nonatomic, copy) NSString *caller_tel;
@property (nullable, nonatomic, copy) NSString *format_visitor_time;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *visitor_name;
@property (nullable, nonatomic, copy) NSString *visitor_tel;
@property (nullable, nonatomic, copy) NSString *vr_id;
@property (nullable, nonatomic, copy) NSString *visitor_id;

@end

NS_ASSUME_NONNULL_END
