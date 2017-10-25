//
//  AllPoliceBlack+CoreDataProperties.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//
//

#import "AllPoliceBlack+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AllPoliceBlack (CoreDataProperties)

+ (NSFetchRequest<AllPoliceBlack *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *pbl_id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *note;

@end

NS_ASSUME_NONNULL_END
