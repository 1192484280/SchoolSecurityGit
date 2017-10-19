//
//  XGJLModel.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGJLModel : NSObject

//巡更id
@property (nonatomic, copy) NSString *p_id;

//巡更时间
@property (nonatomic, copy) NSString *patrol_time;

//扫描点个数
@property (nonatomic, copy) NSString *psr_number;

//巡更距离
@property (nonatomic, copy) NSString *distance;

@end
