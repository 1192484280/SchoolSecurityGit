//
//  FKManager+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FKManager+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FKManager (CoreDataProperties)

+ (NSFetchRequest<FKManager *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id_name;
@property (nullable, nonatomic, copy) NSString *visitor_tel;
@property (nullable, nonatomic, copy) NSString *visitor_time;
@property (nullable, nonatomic, copy) NSString *visits_number;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *visitor_id;

@end

NS_ASSUME_NONNULL_END
