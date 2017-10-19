//
//  LFDetailEditViewController.h
//  SecurityManager
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

//访客操作，通知刷新页面
typedef void (^ifLetGoBlock)(void);

@interface LFDetailEditViewController : BaseViewController

@property (strong, nonatomic) ifLetGoBlock ifLetGoBlock;

- (void)returnMyBlock:(ifLetGoBlock)block;

//访问ID
@property (copy, nonatomic) NSString* vr_id;


@property (strong, nonatomic) IBOutlet UIButton *headerImBtn;

@property (strong, nonatomic) IBOutlet UITextField *lf_nameText;

@property (strong, nonatomic) IBOutlet UITextField *lf_telText;

@property (strong, nonatomic) IBOutlet UITextField *lf_idCardText;


@property (strong, nonatomic) IBOutlet UITextField *lf_dateText;

@property (strong, nonatomic) IBOutlet UITextField *lf_carIdText;

@property (strong, nonatomic) IBOutlet UIButton *lf_otherNumBtn;

@property (strong, nonatomic) IBOutlet UITextField *sf_phoneText;

@property (strong, nonatomic) IBOutlet UITextField *sf_telText;

//电话btn
@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;

//座机btn
@property (strong, nonatomic) IBOutlet UIButton *telBtn;

@property (strong, nonatomic) IBOutlet UIButton *sf_peopleBtn;
@property (strong, nonatomic) IBOutlet UIButton *sf_partBtn;
@property (strong, nonatomic) IBOutlet UILabel *statusLa;
@property (strong, nonatomic) IBOutlet UIButton *agreeGoBtn;

@property (strong, nonatomic) IBOutlet UIButton *refuseGoBtn;
@property (strong, nonatomic) IBOutlet UILabel *fkStatusLa;

@property (strong, nonatomic) IBOutlet UIView *loginoutView;
@property (strong, nonatomic) IBOutlet UIButton *loginoutBtn;
@end
