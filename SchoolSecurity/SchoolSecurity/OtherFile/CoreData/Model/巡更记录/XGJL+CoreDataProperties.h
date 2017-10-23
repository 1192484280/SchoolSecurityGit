//
//  XGJL+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "XGJL+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface XGJL (CoreDataProperties)

+ (NSFetchRequest<XGJL *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *p_id;
@property (nullable, nonatomic, copy) NSString *patrol_time;
@property (nullable, nonatomic, copy) NSString *psr_number;
@property (nullable, nonatomic, copy) NSString *distance;

@end

NS_ASSUME_NONNULL_END
