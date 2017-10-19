//
//  LFSearchViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFSearchViewController.h"
#import "LFManagerSearchResultViewController.h"
#import "LFParametersModel.h"

@interface LFSearchViewController ()<UITextFieldDelegate>
{
    
    IBOutlet NSLayoutConstraint *viewY;
}
@property (strong, nonatomic) LFParametersModel *parameterModel;

@end

@implementation LFSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTextFiled];
    
    [self addShownWithY:iPhoneX_Top];
    
    viewY.constant = (iPhoneX_Top) + topSpacing;
    
    [self setupBackBtnNavBarWithTitle:@"高级搜索"];
}

- (void)setTextFiled{
    
    self.lf_telText.keyboardType = UIKeyboardTypeNumberPad;
    self.sf_telText.keyboardType = UIKeyboardTypeNumberPad;
    self.yy_endText.delegate =self;
    self.yy_startText.delegate = self;
    self.sf_startText.delegate = self;
    self.sf_endText.delegate = self;
    self.yy_startText.inputView = self.datePicker;
    self.yy_endText.inputView = self.datePicker;
    self.sf_startText.inputView = self.datePicker;
    self.sf_endText.inputView = self.datePicker;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    textField.text = @"";
    if ([textField isEqual:self.yy_startText]) {
        
        self.textFiled = self.yy_startText;
        
    }else if ([textField isEqual:self.yy_endText]){
        
        self.textFiled = self.yy_endText;
        
    }else if ([textField isEqual:self.sf_startText]){
        
        self.textFiled = self.sf_startText;
        
    }else{
        
        self.textFiled = self.sf_endText;
    }
    
    return YES;
}

- (IBAction)onSearchBtn:(UIButton *)sender {

    
    if (!(self.lf_nameText.text.length > 0) && !(self.lf_telText.text.length > 0) && !(self.sf_nameText.text.length > 0) && !(self.sf_telText.text.length > 0) && !(self.yy_startText.text.length > 0) && !(self.yy_endText.text.length > 0) && !(self.sf_startText.text.length > 0) && !(self.sf_endText.text.length > 0)) {
        
        [MBProgressHUD showError:@"选择至少一个检索条件" toView:self.view];
        return;
    }
    
    /*
     给parametermodel赋值
     */
    LFParametersModel *model = [[LFParametersModel alloc] init];
    model.school_id = [UserDefaultsTool getSchoolId];
    model.page = @"1";
    model.id_name = self.lf_nameText.text;
    model.visitor_tel = self.lf_telText.text;
    model.caller_name = self.sf_nameText.text;
    model.caller_tel = self.sf_telText.text;
    model.visitor_time_start = self.yy_startText.text;
    model.visitor_time_end = self.yy_endText.text;
    model.login_time_start = self.sf_startText.text;
    model.login_time_end = self.sf_endText.text;
    LFManagerSearchResultViewController *VC = [[LFManagerSearchResultViewController alloc] init];
    VC.parameterModel = model;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
