//
//  FKDetail+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FKDetail+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FKDetail (CoreDataProperties)

+ (NSFetchRequest<FKDetail *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *visitor_id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *tel;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *wx_id;
@property (nullable, nonatomic, copy) NSString *school_list;
@property (nullable, nonatomic, copy) NSString *birthday;

@end

NS_ASSUME_NONNULL_END
