//
//  LFParametersModel.h
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFParametersModel : NSObject

//学校id(必填)
@property (nonatomic, copy) NSString *school_id;

//身份证号
@property (nonatomic, copy) NSString *id_card;

//访问者姓名
@property (nonatomic, copy) NSString *id_name;

//访问状态
@property (nonatomic, copy) NSString *status;

//受访人电话
@property (nonatomic, copy) NSString *caller_tel;

//受访人姓名
@property (nonatomic, copy) NSString *caller_name;

//访问者电话
@property (nonatomic, copy) NSString *visitor_tel;

//预约开始时间
@property (nonatomic, copy) NSString *visitor_time_start;

//预约结束时间
@property (nonatomic, copy) NSString *visitor_time_end;

//接访开始时间
@property (nonatomic, copy) NSString *login_time_start;

//接访结束时间
@property (nonatomic, copy) NSString *login_time_end;

//访客ID
@property (nonatomic, copy) NSString *visitor_id;

//分页
@property (nonatomic, copy) NSString *page;



@end
