//
//  ScanList.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ScanList.h"

@implementation ScanList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.scanModel = [[ScanModel alloc] init];
    }
    
    return self;
}

+ (instancetype)sharedInstance{
    
    static ScanList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[ScanList alloc] init];
    });
    return sharedClient;
}

@end
