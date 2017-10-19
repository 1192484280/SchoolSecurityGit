//
//  OtherVisiterAddViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "OtherVisiterAddViewController.h"
#import "OtherVisiterList.h"
#import "OtherVisiterModel.h"

@interface OtherVisiterAddViewController ()<UITextFieldDelegate>
{
    
    IBOutlet NSLayoutConstraint *shownY;
    
    IBOutlet NSLayoutConstraint *viewY;
    
    IBOutlet NSLayoutConstraint *viewBottom;
    IBOutlet UITextField *text_name;
    
    IBOutlet UITextField *text_ID;
    
    IBOutlet UITextField *text_gender;
    
    IBOutlet UITextField *text_nation;
    
    IBOutlet UITextField *text_birth;
    
    IBOutlet UITextField *text_address;
    
    IBOutlet UITextField *text_part;
    
    IBOutlet UITextField *text_date_start;
    
    IBOutlet UITextField *text_date_end;
    
}



@end

@implementation OtherVisiterAddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    shownY.constant = iPhoneX_Top;
    viewY.constant = (iPhoneX_Top) + 0.5;
    viewBottom.constant = iPhoneX_Bottom;
    
    text_date_start.inputView = self.datePicker;
    text_date_end.inputView = self.datePicker;
    text_date_end.delegate = self;
    text_date_start.delegate = self;
    text_birth.delegate = self;
    [self setupBackBtnNavBarWithTitle:@"添加其他访客信息"];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    textField.text = @"";
    if ([textField isEqual:text_date_start]) {
        
        self.textFiled = text_date_start;
        
    }else if([textField isEqual:text_date_end]){
        
        self.textFiled = text_date_end;
    }else{
        
        self.textFiled = text_birth;
    }
    
    return YES;
}


#pragma mark - 身份证扫描
- (IBAction)onScanIDCardBtn:(UIButton *)sender {
    
    [IDInfoList sharedInstance].idInfo = [[IDInfo alloc] init];
    
    AVCaptureViewController *VC = [[AVCaptureViewController alloc] init];
    VC.type = 2;
    [VC returnText:^{
        
        text_name.text = [IDInfoList sharedInstance].idInfo.name;
        text_ID.text = [IDInfoList sharedInstance].idInfo.num;
        text_gender.text = [IDInfoList sharedInstance].idInfo.gender;
        text_nation.text = [IDInfoList sharedInstance].idInfo.nation;
        text_birth.text = [IDInfoList sharedInstance].idInfo.birth;
        text_address.text = [IDInfoList sharedInstance].idInfo.address;
        text_part.text = [IDInfoList sharedInstance].idInfo.issue;
        
        text_date_start.text = [IDInfoList sharedInstance].idInfo.start_date;
        text_date_end.text = [IDInfoList sharedInstance].idInfo.end_date;
    }];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)onNextBtn:(UIButton *)sender {
    
    
    if (!(text_name.text.length > 0)) {
        
        [self showMBPError:@"请填写随行人员姓名"];
        
        return;
    }
    
    if (!(text_ID.text.length > 0)) {
        
        [self showMBPError:@"请填写随行人员身份证号"];
        
        return;
    }
    
    if (!(text_gender.text.length > 0)) {
        
        [self showMBPError:@"请填写随行人员性别"];
        
        return;
    }
    
    if (!(text_nation.text.length > 0)) {
        
        [self showMBPError:@"请填写随行人员民族"];
        
        return;
    }
    
    if (!(text_birth.text.length > 0)) {
        
        [self showMBPError:@"请填写随行人员生日"];
        
        return;
    }
    if (!(text_address.text.length > 0)) {
        
        [self showMBPError:@"请填写随行人员住址"];
        
        return;
    }
    if (!(text_part.text.length > 0)) {
        
        [self showMBPError:@"请填写身份证签发机关"];
        
        return;
    }
    
    if (!(text_date_start.text.length > 0) || !(text_date_end.text.length > 0)) {
        
        [self showMBPError:@"请填写身份证有效日期"];
        
        return;
    }
    
    OtherVisiterModel *model = [[OtherVisiterModel alloc] init];
    model.name = text_name.text;
    model.id_card = text_ID.text;
    
    if ([text_gender.text isEqualToString:@"男"]) {
        
        model.gender = @"1";
    }else{
        
        model.gender = @"2";
    }
    
    model.nation = text_nation.text;
    model.birthday = text_birth.text;
    model.address = text_address.text;
    model.part = text_part.text;
    model.start_date = text_date_start.text;
    model.end_date = text_date_end.text;
    
    [[OtherVisiterList sharedInstance].otherVisiterListArr addObject:model];
    
    [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
    
    text_name.text = @"";
    text_ID.text = @"";
    text_gender.text = @"";
    text_nation.text = @"";
    text_birth.text = @"";
    text_address.text = @"";
    text_part.text = @"";
    text_date_start.text = @"";
    text_date_end.text = @"";
    
}

- (void)back{
    
    if (self.otherBlock != nil) {
        
        self.otherBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnOtherBlock:(otherBlock)block{
    
    self.otherBlock = block;
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
