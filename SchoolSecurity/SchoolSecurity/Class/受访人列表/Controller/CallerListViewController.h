//
//  CallerListViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import "CallerModel.h"

typedef void(^callerBlock)(CallerModel *model);

@interface CallerListViewController : BaseViewController

@property (nonatomic, copy) NSString *orgId;

@property (strong , nonatomic) callerBlock callerBlock;

- (void)returnText:(callerBlock)block;

@end
