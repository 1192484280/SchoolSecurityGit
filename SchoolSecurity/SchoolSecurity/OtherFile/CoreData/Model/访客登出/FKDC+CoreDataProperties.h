//
//  FKDC+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "FKDC+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FKDC (CoreDataProperties)

+ (NSFetchRequest<FKDC *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *vr_id;
@property (nullable, nonatomic, copy) NSString *schoolId;
@property (nullable, nonatomic, copy) NSString *securityId;

@end

NS_ASSUME_NONNULL_END
