//
//  XGStartViewController.h
//  SecurityManager
//
//  Created by zhangming on 17/8/29.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^XGEndBlock)(void);

@interface XGStartViewController : BaseViewController

@property (strong, nonatomic) XGEndBlock xgEndBlock;
- (void)returnXGEndBlock:(XGEndBlock)block;

@property (strong, nonatomic) IBOutlet UILabel *rangeLa;
@property (strong, nonatomic) IBOutlet UIButton *xgBtn;

@end
