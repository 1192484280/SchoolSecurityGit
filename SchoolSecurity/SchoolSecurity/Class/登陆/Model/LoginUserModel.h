//
//  LoginUserModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUserModel : NSObject

//学校id
@property (nonatomic, copy) NSString *school_id;

//保安id
@property (nonatomic, copy) NSString *security_personnel_id;

//姓名
@property (nonatomic, copy) NSString *name;

//性别
@property (nonatomic, copy) NSString *sex;

//年龄
@property (nonatomic, copy) NSString *age;

//电话
@property (nonatomic, copy) NSString *mphone;

//座机
@property (nonatomic, copy) NSString *tel;

//状态
@property (nonatomic, copy) NSString *status;

//添加时间
@property (nonatomic, copy) NSString *add_time;

//修改时间
@property (nonatomic, copy) NSString *edit_time;

//登录账号
@property (nonatomic, copy) NSString *user_account;

//登陆密码
@property (nonatomic, copy) NSString *password;

//离职日期
@property (nonatomic, copy) NSString *date_leave;

//头像
@property (nonatomic, copy) NSString *headimg;



@end
