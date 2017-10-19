//
//  OtherVisiterList.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherVisiterList : NSObject

@property (strong, nonatomic) NSMutableArray *otherVisiterListArr;

+ (instancetype)sharedInstance;

@end
