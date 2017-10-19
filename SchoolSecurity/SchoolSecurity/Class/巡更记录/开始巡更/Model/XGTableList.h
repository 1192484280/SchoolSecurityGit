//
//  XGTableList.h
//  SchoolSecurity
//
//  Created by zhangming on 17/10/10.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XGTableModel.h"

@interface XGTableList : NSObject

@property (nonatomic, copy) NSString *p_id;

@property (strong, nonatomic) XGTableModel *xgTableModel;

+ (instancetype)sharedInstance;

@end
