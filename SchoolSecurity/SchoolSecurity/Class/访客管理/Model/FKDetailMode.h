//
//  FKDetailMode.h
//  SecurityManager
//
//  Created by zhangming on 17/9/14.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKDetailMode : NSObject

//访客id
@property (nonatomic, copy) NSString *visitor_id;

//访客姓名
@property (nonatomic, copy) NSString *name;

//性别 1男，2女
@property (nonatomic, copy) NSString *sex;

//访客电话
@property (nonatomic, copy) NSString *tel;

//访客身份证号
@property (nonatomic, copy) NSString *id_card;

//状态
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *wx_id;

//学校id
@property (nonatomic, copy) NSString *school_list;

//访客出生日期
@property (nonatomic, copy) NSString *birthday;

@end
