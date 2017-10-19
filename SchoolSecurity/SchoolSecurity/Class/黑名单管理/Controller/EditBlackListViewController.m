//
//  EditBlackListViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "EditBlackListViewController.h"

@interface EditBlackListViewController ()
{
    
    IBOutlet NSLayoutConstraint *viewY;
}
@end

@implementation EditBlackListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"编辑黑名单"];
    
    [self addShownWithY:iPhoneX_Top];
    
    viewY.constant = (iPhoneX_Top) + topSpacing;
    
    [self setUI];
}

- (void)setUI{
    
    if (self.blackListType == SchoolBlackList) {
        
        self.nameText.text = self.schoolModel.name;
        self.id_cardText.text = self.schoolModel.id_card;
        self.noteText.text = self.schoolModel.note;
        
    }else{
        
        self.nameText.text = self.policeModel.name;
        self.id_cardText.text = self.policeModel.id_card;
        self.noteText.text = self.policeModel.note;
    }
    
    
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

    NSString *schoolId = self.schoolId;
    NSString *name  = self.nameText.text;
    NSString *note = self.noteText.text;
    NSString *idCard = self.id_cardText.text;
    
    MJWeakSelf
    [store editBlackListWithParameterId:self.Id andSchoolId:schoolId andName:name andIdCard:idCard andNote:note andType:self.blackListType Success:^{
        
        if (weakSelf.editBlackBlock != nil) {
            
            weakSelf.editBlackBlock();
        }
        [weakSelf showSVPSuccess:@"修改成功"];
        
        [weakSelf performSelector:@selector(goBack) withObject:nil afterDelay:1];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
    
}
- (IBAction)onDeleteBtn:(UIButton *)sender {
    
    
    MJWeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"信确认删除" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf addLoadingView];
        
        BaseStore *store = [[BaseStore alloc] init];
        
        [store deleteBlackListWithId:weakSelf.Id andType:weakSelf.blackListType Success:^{
            
            [weakSelf removeLoadingView];
            
            if (weakSelf.editBlackBlock != nil) {
                
                weakSelf.editBlackBlock();
            }
            [weakSelf showSVPSuccess:@"删除成功"];
            
            [weakSelf performSelector:@selector(goBack) withObject:nil afterDelay:1];
            
        } Failure:^(NSError *error) {
            
            [weakSelf removeLoadingView];
            
            [weakSelf showSVPError:[HttpTool handleError:error]];
        }];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}

- (void)goBack{
    
    [self removeLoadingView];
    [SVProgressHUD dismiss];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnMyBlock:(EditBlackList)block{
    
    self.editBlackBlock = block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
