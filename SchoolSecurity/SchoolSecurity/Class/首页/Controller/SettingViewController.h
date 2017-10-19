//
//  SettingViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/10/10.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^loginOutBlock)(void);

@interface SettingViewController : BaseViewController

@property (strong, nonatomic) loginOutBlock loginOutBlock;

- (void)returnBlock:(loginOutBlock)block;

@end
