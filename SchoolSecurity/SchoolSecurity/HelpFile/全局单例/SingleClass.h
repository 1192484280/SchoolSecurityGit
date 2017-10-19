//
//  SingleClass.h
//  SecurityManager
//
//  Created by zhangming on 17/8/31.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleClass : NSObject

//当前网络状态//0：流量，1：wifi，2：无网络
@property (copy, nonatomic) NSString *networkState;

+ (instancetype)sharedInstance;

@end
