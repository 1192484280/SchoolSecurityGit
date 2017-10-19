//
//  FKManagerSearchViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import "FKParameterModel.h"

typedef void(^searchBlock)(FKParameterModel *model);

@interface FKManagerSearchViewController : BaseViewController

@property (strong , nonatomic) searchBlock searchBlock;

- (void)returnText:(searchBlock)block;

@property (strong, nonatomic) IBOutlet UITextField *nameText;

@property (strong, nonatomic) IBOutlet UIButton *manBtn;

@property (strong, nonatomic) IBOutlet UIButton *womanBtn;

@property (strong, nonatomic) IBOutlet UITextField *telText;
@property (strong, nonatomic) IBOutlet UITextField *startDateText;
@property (strong, nonatomic) IBOutlet UITextField *endDateText;

@end
