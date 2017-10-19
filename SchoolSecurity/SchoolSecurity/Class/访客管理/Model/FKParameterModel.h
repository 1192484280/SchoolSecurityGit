//
//  FKParameterModel.h
//  SecurityManager
//
//  Created by zhangming on 17/9/14.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKParameterModel : NSObject

//学校id
@property (nonatomic, copy) NSString *school_id;

//姓名
@property (nonatomic, copy) NSString *name;

//身份证
@property (nonatomic, copy) NSString *id_card;

//电话
@property (nonatomic, copy) NSString *visitor_tel;

//分页
@property (nonatomic, copy) NSString * page;

//性别
@property (nonatomic, copy) NSString *sex;

//访问开始时间
@property (nonatomic, copy) NSString *srtart_login_time;

//访问结束时间
@property (nonatomic, copy) NSString *end_login_time;

@end
