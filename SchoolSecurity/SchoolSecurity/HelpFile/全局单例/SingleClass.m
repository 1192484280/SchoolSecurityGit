//
//  SingleClass.m
//  SecurityManager
//
//  Created by zhangming on 17/8/31.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SingleClass.h"

@implementation SingleClass


+ (instancetype)sharedInstance{
    static SingleClass *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[SingleClass alloc] init];
    });
    return sharedClient;
}
@end
