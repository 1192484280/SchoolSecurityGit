//
//  ScanList.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScanModel.h"

@interface ScanList : NSObject

//扫描结果
@property (strong, nonatomic) ScanModel *scanModel;

+ (instancetype)sharedInstance;

@end
