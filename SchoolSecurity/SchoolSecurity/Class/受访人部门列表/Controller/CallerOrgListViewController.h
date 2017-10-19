//
//  CallerOrgListViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import "CallerOrgModel.h"

typedef void(^OrgBlock)(CallerOrgModel *model);

@interface CallerOrgListViewController : BaseViewController

@property (strong , nonatomic) OrgBlock orgBlock;

- (void)returnText:(OrgBlock)block;

@end
