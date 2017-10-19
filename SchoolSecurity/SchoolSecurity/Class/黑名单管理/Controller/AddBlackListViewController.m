//
//  AddBlackListViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "AddBlackListViewController.h"

@interface AddBlackListViewController ()
{
    
    IBOutlet NSLayoutConstraint *viewY;
}
@end

@implementation AddBlackListViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"添加黑名单"];
    
    [self addShownWithY:iPhoneX_Top];
    
    viewY.constant = (iPhoneX_Top) + topSpacing;
    
}
- (IBAction)onSaveBtn:(UIButton *)sender {
    
    if (!(self.nameText.text.length > 0)) {
        
        [self showMBPError:@"输入姓名"];
        return;
    }
    
    if (!(self.id_cardText.text.length > 0)) {
        
        
        [self showMBPError:@"输入身份证号"];
        return;
    }
    
    if (![StrTool checkUserID:self.id_cardText.text]) {
        
        [self showMBPError:@"请输入正确身份证号"];
        return ;
    }
    
    if (!(self.noteText.text.length > 0)) {
        
        [self showMBPError:@"输入备注"];
        return;
    }
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *schoolId = [UserDefaultsTool getSchoolId];
    NSString *idCard = self.id_cardText.text;
    NSString *name = self.nameText.text;
    NSString *note = self.noteText.text;
    
    MJWeakSelf
    [store addBlackListWithSchoolId:schoolId andIdCard:idCard andName:name andNote:note andType:self.blackListType Success:^{
        
        [weakSelf removeLoadingView];
        
        if (weakSelf.addBlackBlock != nil) {
            
            weakSelf.addBlackBlock();
        }
        
        [weakSelf performSelector:@selector(goBack) withObject:nil afterDelay:1];
        
        [weakSelf showSVPSuccess:@"保存成功"];
        
    } Failure:^(NSError *error) {
        
        [weakSelf removeLoadingView];
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
    
}

- (void)goBack{
    
    [SVProgressHUD dismiss];
    [self removeLoadingView];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnMyBlock:(addBlackList)block{
    
    self.addBlackBlock = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
