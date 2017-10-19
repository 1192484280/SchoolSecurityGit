//
//  XGTableList.m
//  SchoolSecurity
//
//  Created by zhangming on 17/10/10.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGTableList.h"

@implementation XGTableList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.xgTableModel = [[XGTableModel alloc] init];
    }
    return self;
}

+ (instancetype)sharedInstance{
    
    static XGTableList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[XGTableList alloc] init];
    });
    return sharedClient;
}

@end
