//
//  XGDetail+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/23.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "XGDetail+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface XGDetail (CoreDataProperties)

+ (NSFetchRequest<XGDetail *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *distance;
@property (nullable, nonatomic, copy) NSString *headimg;
@property (nullable, nonatomic, copy) NSString *line;
@property (nullable, nonatomic, copy) NSString *p_id;
@property (nullable, nonatomic, copy) NSString *patrol_add_time;
@property (nullable, nonatomic, copy) NSString *patrol_end_time;
@property (nullable, nonatomic, copy) NSString *security_personnel_id;
@property (nullable, nonatomic, copy) NSString *sp_name;
@property (nullable, nonatomic, retain) NSData *psr_info;

@end

NS_ASSUME_NONNULL_END
