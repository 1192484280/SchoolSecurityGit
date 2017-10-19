//
//  XGDetailModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

/*
 {
 data =     {
 1 =         {
 distance = "3.5";
 headimg = "uploads/visitor/2017-09-14/2.jpg";
 line = "[ {  \"latitude\" : \"39.902136\",\"longtitude\" : \"116.44095\"},{\"latitude\" : \"39.902136\",\"longtitude\" : \"116.42095\",},{\"latitude\" : \"39.832136\",\"longtitude\" : \"116.42095\"},{\"latitude\" : \"39.832136\",\"longtitude\" : \"116.34095\"}]
 \n";
 "p_id" = 1;
 "patrol_add_time" = "2017/09/12 16:55:44";
 "patrol_end_time" = "2017/09/14 17:25:14";
 "psr_info" =             (
 {
 name = "\U7b2c\U4e09\U68c0\U67e5\U70b9";
 note = 2222;
 "psr_add_time" = "2017/09/12 16:55:44";
 "psr_status" = "\U6b63\U5e38";
 },
 {
 name = "\U7b2c\U4e8c\U68c0\U67e5\U70b9";
 note = 2222;
 "psr_add_time" = "2017/09/12 16:55:44";
 "psr_status" = "\U6b63\U5e38";
 },
 {
 name = "\U7b2c\U4e00\U68c0\U67e5\U70b9";
 note = 1212;
 "psr_add_time" = "2017/09/12 16:55:44";
 "psr_status" = "\U6b63\U5e38";
 }
 );
 "security_personnel_id" = 2;
 "sp_name" = "\U738b\U9ebb\U5b50";
 };
 };
 msg = "";
 render = 1;
 status = 200;
 url = "";
 }

 */
#import <Foundation/Foundation.h>

@interface XGDetailModel : NSObject

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *headimg;

@property (nonatomic, copy) NSString *line;

@property (nonatomic, copy) NSString *p_id;

@property (nonatomic, copy) NSString *patrol_add_time;

@property (nonatomic, copy) NSString *patrol_end_time;

@property (nonatomic, copy) NSArray *psr_info;

@property (nonatomic, copy) NSString *security_personnel_id;

@property (nonatomic, copy) NSString *sp_name;
@end
