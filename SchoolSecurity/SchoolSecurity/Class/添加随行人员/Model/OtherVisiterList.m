//
//  OtherVisiterList.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "OtherVisiterList.h"

@implementation OtherVisiterList

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.otherVisiterListArr = [NSMutableArray array];
    }
    return self;
    
}
+ (instancetype)sharedInstance{
    
    static OtherVisiterList *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[OtherVisiterList alloc] init];
    });
    return sharedClient;
}
@end
