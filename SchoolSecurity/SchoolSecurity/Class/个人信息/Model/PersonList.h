//
//  PersonList.h
//  SecurityManager
//
//  Created by zhangming on 17/9/18.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInfoModel.h"
#import "PersonParameterModel.h"

@interface PersonList : NSObject

@property (strong, nonatomic) PersonInfoModel *personModel;

@property (strong, nonatomic) PersonParameterModel *parameterModel;

+ (instancetype)sharedInstance;

@end
