//
//  LFModel.h
//  SecurityManager
//
//  Created by zhangming on 17/9/8.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFModel : NSObject

//预约时间
@property (nonatomic, copy) NSString *format_visitor_time;

//备注
@property (nonatomic, copy) NSString *note;

//状态
@property (nonatomic, copy) NSString *status;

//访问id
@property (nonatomic, copy) NSString *vr_id;

//访问姓名
@property (nonatomic, copy) NSString *visitor_name;

//访问电话
@property (nonatomic, copy) NSString *visitor_tel;

//受访人姓名
@property (nonatomic, copy) NSString *caller_name;

//受访人电话
@property (nonatomic, copy) NSString *caller_tel;

//
@end
