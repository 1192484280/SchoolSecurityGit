//
//  PersonList.m
//  SecurityManager
//
//  Created by zhangming on 17/9/18.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "PersonList.h"

@implementation PersonList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.personModel = [[PersonInfoModel alloc] init];
        self.parameterModel = [[PersonParameterModel alloc] init];
    }
    
    return self;
}

+ (instancetype)sharedInstance{
    
    static PersonList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[PersonList alloc] init];
    });
    return sharedClient;
}

@end
