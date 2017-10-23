//
//  LoginViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/16.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseStore.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    //账号
    IBOutlet UITextField *accountText;
    
    //密码
    IBOutlet UITextField *passText;
    
    IBOutlet NSLayoutConstraint *viewY;
}
@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = VIEWCOLOR;
    
    //测试
    passText.keyboardType = UIKeyboardTypeNumberPad;
    accountText.keyboardType = UIKeyboardTypeNumberPad;
    
    [self setupBackBtnNavBarWithTitle:@"登陆"];
    
    [self addShownWithY:iPhoneX_Top];
    
    viewY.constant = (iPhoneX_Top) + topSpacing;
    
    accountText.delegate = self;
    passText.delegate = self;

    accountText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    passText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    [self login];
    
    return YES;
}


- (IBAction)onLoginBtn:(UIButton *)sender {
    
    [self login];
}

- (void)login{
    
    [self.view endEditing:YES];
    if (! (accountText.text.length > 0)) {
        
        [self showMBPError:@"输入账号"];
        return;
    }
    
    if (! (passText.text.length > 0)) {
        
        [self showMBPError:@"输入密码"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"登录中.."];
    
    MJWeakSelf
    BaseStore *store = [[BaseStore alloc] init];
    NSString *account = accountText.text;
    NSString *passWord = passText.text;
    [store LoginWithAccount:account andPassWord:passWord Sucess:^(LoginUserModel *model) {
        
        [UserDefaultsTool setObj:model.school_id andKey:@"school_id"];
        [UserDefaultsTool setObj:model.security_personnel_id andKey:@"security_personnel_id"];
        [UserDefaultsTool setObj:model.name andKey:@"userName"];
        [UserDefaultsTool setObj:model.mphone andKey:@"mphone"];
        [UserDefaultsTool setObj:model.headimg andKey:@"userHeadimg"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [weakSelf showSVPSuccess:@"成功登陆"];
        
        if (weakSelf.loginBlock != nil) {
            
            weakSelf.loginBlock();
        }
        [weakSelf performSelector:@selector(back) withObject:nil afterDelay:1.0f];
        
    } failure:^(NSError *error) {
       
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
    
    
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [SVProgressHUD dismiss];
}

- (void)returnLoginBlock:(loginBlock)block{
    
    self.loginBlock = block;
}
- (IBAction)onEyeBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        passText.secureTextEntry = NO;
    }else{
        
        passText.secureTextEntry = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
