//
//  FKModel.h
//  SecurityManager
//
//  Created by zhangming on 17/9/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKModel : NSObject

//姓名
@property (nonatomic, copy) NSString *id_name;

//电话
@property (nonatomic, copy) NSString *visitor_tel;

//最后时间
@property (nonatomic, copy) NSString *visitor_time;

//来访次数
@property (nonatomic, copy) NSString *visits_number;

//身份证号
@property (nonatomic, copy) NSString *id_card;

//访客id
@property (nonatomic, copy) NSString *visitor_id;

@end
