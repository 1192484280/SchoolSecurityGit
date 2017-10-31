//
//  ScanLogout+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/31.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "ScanLogout+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ScanLogout (CoreDataProperties)

+ (NSFetchRequest<ScanLogout *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *idCard;
@property (nullable, nonatomic, copy) NSString *securityId;

@end

NS_ASSUME_NONNULL_END
