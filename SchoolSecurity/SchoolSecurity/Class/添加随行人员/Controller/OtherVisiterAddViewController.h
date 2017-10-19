//
//  OtherVisiterAddViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^otherBlock)(void);

@interface OtherVisiterAddViewController : BaseViewController

@property (strong, nonatomic) otherBlock otherBlock;

- (void)returnOtherBlock:(otherBlock)block;

@end
