//
//  AllSchoolBlack+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "AllSchoolBlack+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AllSchoolBlack (CoreDataProperties)

+ (NSFetchRequest<AllSchoolBlack *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *bl_id;
@property (nullable, nonatomic, copy) NSString *school_id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *note;

@end

NS_ASSUME_NONNULL_END
