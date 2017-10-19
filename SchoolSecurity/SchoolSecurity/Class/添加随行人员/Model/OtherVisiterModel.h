//
//  OtherVisiterModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherVisiterModel : NSObject


//姓名
@property (nonatomic, copy) NSString *name;

//身份证号
@property (nonatomic, copy) NSString *id_card;

//性别
@property (nonatomic, copy) NSString *gender;

//民族
@property (nonatomic, copy) NSString *nation;

//生日
@property (nonatomic, copy) NSString *birthday;

//住址
@property (nonatomic, copy) NSString *address;

//签发机关
@property (nonatomic, copy) NSString *part;

//签发日期
@property (nonatomic, copy) NSString *start_date;

//失效日期
@property (nonatomic, copy) NSString *end_date;

@end
