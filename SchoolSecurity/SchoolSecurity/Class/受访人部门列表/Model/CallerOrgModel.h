//
//  CallerOrgModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallerOrgModel : NSObject

//部门ID
@property (nonatomic, copy) NSString *org_id;

//学校ID
@property (nonatomic, copy) NSString *school_id;

//部门名称
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parent_id;

@end
