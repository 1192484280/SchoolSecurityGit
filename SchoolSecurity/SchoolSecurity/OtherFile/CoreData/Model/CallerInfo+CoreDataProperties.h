//
//  CallerInfo+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/18.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "CallerInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CallerInfo (CoreDataProperties)

+ (NSFetchRequest<CallerInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *caller_id;
@property (nullable, nonatomic, copy) NSString *mphone;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *org_id;
@property (nullable, nonatomic, copy) NSString *school_id;
@property (nullable, nonatomic, copy) NSString *tel;

@end

NS_ASSUME_NONNULL_END
