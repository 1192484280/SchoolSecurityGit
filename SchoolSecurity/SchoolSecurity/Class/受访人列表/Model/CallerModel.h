//
//  CallerModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallerModel : NSObject

//受访人ID
@property (nonatomic, copy) NSString *caller_id;

//部门ID
@property (nonatomic, copy) NSString *org_id;

//学校ID
@property (nonatomic, copy) NSString *school_id;

//受访人名称
@property (nonatomic, copy) NSString *name;

//受访人手机
@property (nonatomic, copy) NSString *mphone;

//受访人座机电话
@property (nonatomic, copy) NSString *tel;

@end
