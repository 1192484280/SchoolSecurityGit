//
//  EditBlackListViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import "PoliceBlackListModel.h"
#import "SchoolBlackListModel.h"

typedef void (^EditBlackList)(void);

@interface EditBlackListViewController : BaseViewController

@property (strong, nonatomic) EditBlackList editBlackBlock;

- (void)returnMyBlock:(EditBlackList)block;

@property (strong, nonatomic) SchoolBlackListModel *schoolModel;
@property (strong, nonatomic) PoliceBlackListModel *policeModel;

@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *id_cardText;
@property (strong, nonatomic) IBOutlet UITextView *noteText;


@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *schoolId;

@end
