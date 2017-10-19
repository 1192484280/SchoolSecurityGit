//
//  IDInfoList.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IDInfoList.h"

@implementation IDInfoList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.idInfo = [[IDInfo alloc] init];
    }
    return self;
}
+ (instancetype)sharedInstance{
    
    static IDInfoList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[IDInfoList alloc] init];
    });
    return sharedClient;
}

@end
