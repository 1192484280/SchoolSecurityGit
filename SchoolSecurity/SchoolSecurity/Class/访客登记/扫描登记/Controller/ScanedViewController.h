//
//  ScanedViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

@interface ScanedViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIButton *caller_orgBtn;

@property (strong, nonatomic) IBOutlet UIButton *caller_nameBtn;

@property (strong, nonatomic) IBOutlet UITextField *caller_phoneTf;

@property (strong, nonatomic) IBOutlet UITextField *caller_telTf;

@property (strong, nonatomic) IBOutlet UIButton *visiter_headImBtn;

@property (strong, nonatomic) IBOutlet UITextField *visiter_nameTf;

@property (strong, nonatomic) IBOutlet UITextField *visiter_phoneTf;

@property (strong, nonatomic) IBOutlet UITextField *visiter_idcardTf;

@property (strong, nonatomic) IBOutlet UITextField *visiter_dateTf;

@property (strong, nonatomic) IBOutlet UITextField *visiter_carTf;

@property (strong, nonatomic) IBOutlet UIButton *caller_otherNumBtn;

@property (strong, nonatomic) IBOutlet UILabel *statusLa;

@property (strong, nonatomic) IBOutlet UIButton *agreeBtn;
@property (strong, nonatomic) IBOutlet UIButton *refuseBtn;

@property (strong, nonatomic) IBOutlet UILabel *fkStatus;
@end
