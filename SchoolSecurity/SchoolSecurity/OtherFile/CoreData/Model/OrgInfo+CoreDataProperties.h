//
//  OrgInfo+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/18.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "OrgInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OrgInfo (CoreDataProperties)

+ (NSFetchRequest<OrgInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *org_id;

@end

NS_ASSUME_NONNULL_END
