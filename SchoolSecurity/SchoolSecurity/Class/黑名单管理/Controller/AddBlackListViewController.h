//
//  AddBlackListViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^addBlackList)(void);

@interface AddBlackListViewController : BaseViewController

@property (strong, nonatomic) addBlackList addBlackBlock;

- (void)returnMyBlock:(addBlackList)block;


@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *id_cardText;
@property (strong, nonatomic) IBOutlet UITextView *noteText;

@end
