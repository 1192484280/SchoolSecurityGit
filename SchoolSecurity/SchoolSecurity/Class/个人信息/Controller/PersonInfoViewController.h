//
//  PersonInfoViewController.h
//  SecurityManager
//
//  Created by zhangming on 17/8/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^changePersonInfoBlock)(void);

@interface PersonInfoViewController : BaseViewController

@property (strong, nonatomic) changePersonInfoBlock changePersonblock;

- (void)returnMyBlock:(changePersonInfoBlock)block;

@end
