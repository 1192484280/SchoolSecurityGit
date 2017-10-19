//
//  ScanParameterModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanParameterModel : NSObject

/*必填----------------------------------------*/

//预约访问id
@property (nonatomic, copy) NSString *vr_id;

//访问者id
@property (nonatomic, copy) NSString *visitor_id;

//学校id
@property (nonatomic, copy) NSString *school_id;

//保安id
@property (nonatomic, copy) NSString *security_personnel_id;

//状态
@property (nonatomic, copy) NSString *status;

//身份证号码
@property (nonatomic, copy) NSString *id_card;

//身份证姓名
@property (nonatomic, copy) NSString *id_name;

//性别1男，2女
@property (nonatomic, copy) NSString *id_sex;

//身份证出生日期
@property (nonatomic, copy) NSString *id_birthday;

//身份证地址
@property (nonatomic, copy) NSString *id_address;

//身份证有效日期
@property (nonatomic, copy) NSString *id_validity_date;

//身份证民族
@property (nonatomic, copy) NSString *id_nation;

//身份证签发机关
@property (nonatomic, copy) NSString *id_release_organ;

//是否随行
@property (nonatomic, copy) NSString *is_other_person;

//是否有车
@property (nonatomic, copy) NSString *is_car;

//来访人照片
@property (nonatomic, copy) NSString *visitor_picture;

//来访人电话
@property (nonatomic, copy) NSString *visitor_tel;

/*非必填----------------------------------------*/


//随行信息
@property (nonatomic, copy) NSString *other_person_list;

//车牌号
@property (nonatomic, copy) NSString *plate_number;

@end
