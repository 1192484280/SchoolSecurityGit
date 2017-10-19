//
//  LoginViewController.h
//  SecurityManager
//
//  Created by zhangming on 17/8/16.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

//无返回
typedef void (^loginBlock)(void);

@interface LoginViewController : BaseViewController

@property (strong, nonatomic) loginBlock loginBlock;


- (void)returnLoginBlock:(loginBlock)block;

@end
