//
//  LFSubViewController.h
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import "LFParametersModel.h"

@interface LFSubViewController : BaseViewController

@property (weak, nonatomic) UITableView *tableView;

- (void)refreshListModel:(LFParametersModel *)model Complete:(void(^)())complete;

@end
