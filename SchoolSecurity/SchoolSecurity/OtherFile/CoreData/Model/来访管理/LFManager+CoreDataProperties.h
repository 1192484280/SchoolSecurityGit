//
//  LFManager+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "LFManager+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LFManager (CoreDataProperties)

+ (NSFetchRequest<LFManager *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *format_visitor_time;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *vr_id;
@property (nullable, nonatomic, copy) NSString *visitor_name;
@property (nullable, nonatomic, copy) NSString *visitor_tel;
@property (nullable, nonatomic, copy) NSString *caller_name;
@property (nullable, nonatomic, copy) NSString *caller_tel;

@end

NS_ASSUME_NONNULL_END
