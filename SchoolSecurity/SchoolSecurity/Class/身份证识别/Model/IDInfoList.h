//
//  IDInfoList.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDInfo.h"

@interface IDInfoList : NSObject

@property (strong, nonatomic) IDInfo *idInfo;

@property (nonatomic, copy) NSString *smResult;

+ (instancetype)sharedInstance;

@end
