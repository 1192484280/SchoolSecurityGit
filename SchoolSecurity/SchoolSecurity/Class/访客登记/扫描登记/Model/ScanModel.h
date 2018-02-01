//
//  ScanModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
// 扫描二维码模型

#import <Foundation/Foundation.h>

@interface ScanModel : NSObject

//预约访问id
@property (nonatomic, copy) NSString *vr_id;

//访问者id
@property (nonatomic, copy) NSString *visitor_id;

@property (nonatomic, copy) NSString *format_visitor_time;

@property (nonatomic, copy) NSString *is_car;

@property (nonatomic, copy) NSString *plate_number;

@property (nonatomic, copy) NSString *is_other_person;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, copy) NSString *visitor_status;

@property (nonatomic, copy) NSString *caller_name;

@property (nonatomic, copy) NSString *caller_mphone;

@property (nonatomic, copy) NSString *caller_tel;

@property (nonatomic, copy) NSString *org_name;

@property (nonatomic, copy) NSString *school_name;

@property (nonatomic, copy) NSString *visitor_name;

@property (nonatomic, copy) NSString *visitor_tel;

@property (nonatomic, copy) NSString *visitor_id_card;

@property (nonatomic, copy) NSString *before_time;

@end
