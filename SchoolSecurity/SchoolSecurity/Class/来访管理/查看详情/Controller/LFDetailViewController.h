//
//  LFDetailViewController.h
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

//访客登出，通知刷新页面
typedef void (^loginoutBlock)(void);

@interface LFDetailViewController : BaseViewController

@property (strong, nonatomic) loginoutBlock loginoutBlock;

- (void)returnMyBlock:(loginoutBlock)block;

//访问ID
@property (copy, nonatomic) NSString* vr_id;

//来访人照片
@property (strong, nonatomic) IBOutlet UIImageView *lf_photoImg;


//来访人姓名
@property (strong, nonatomic) IBOutlet UILabel *lf_nameLa;

//来访人电话
@property (strong, nonatomic) IBOutlet UILabel *lf_telLa;

//来访人身份证
@property (strong, nonatomic) IBOutlet UILabel *lf_idCardLa;

//来访日期
@property (strong, nonatomic) IBOutlet UILabel *lf_dateLa;

//车牌
@property (strong, nonatomic) IBOutlet UILabel *lf_carIDLa;

//随行人员
@property (strong, nonatomic) IBOutlet UIButton *lf_otherBtn;

//受访人姓名
@property (strong, nonatomic) IBOutlet UILabel *sf_name;

//受访人部门
@property (strong, nonatomic) IBOutlet UILabel *sf_partLa;

//电话
@property (strong, nonatomic) IBOutlet UILabel *sf_phoneLa;


//座机
@property (strong, nonatomic) IBOutlet UILabel *sf_telLa;

//电话btn
@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;

//座机btn
@property (strong, nonatomic) IBOutlet UIButton *telBtn;

@property (strong, nonatomic) IBOutlet UILabel *statusLa;


@property (strong, nonatomic) IBOutlet UIButton *fkLoginoutBtn;

@end
