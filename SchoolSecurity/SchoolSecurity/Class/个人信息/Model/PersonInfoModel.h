//
//  PersonInfoModel.h
//  SecurityManager
//
//  Created by zhangming on 17/9/15.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoModel : NSObject

//保安id
@property (nonatomic, copy) NSString *security_personnel_id;

//学校id
@property (nonatomic, copy) NSString *school_id;

//保安身份证号
@property (nonatomic, copy) NSString *id_card;

//保安姓名
@property (nonatomic, copy) NSString *name;

//保安性别
@property (nonatomic, copy) NSString *sex;

//保安年龄
@property (nonatomic, copy) NSString *age;

//保安手机号
@property (nonatomic, copy) NSString *mphone;

//保安座机
@property (nonatomic, copy) NSString *tel;

//保安状态
@property (nonatomic, copy) NSString *status;

//保安添加时间
@property (nonatomic, copy) NSString *add_time;

//最后修改时间
@property (nonatomic, copy) NSString *edit_time;

//登陆账号
@property (nonatomic, copy) NSString *user_account;

//登录密码
@property (nonatomic, copy) NSString *password;

//离职日期
@property (nonatomic, copy) NSString *date_leave;

//保安头像
@property (nonatomic, copy) NSString *headimg;

@end
