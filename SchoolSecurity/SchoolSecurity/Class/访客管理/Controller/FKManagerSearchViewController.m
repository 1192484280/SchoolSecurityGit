//
//  FKManagerSearchViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "FKManagerSearchViewController.h"

@interface FKManagerSearchViewController ()<UITextFieldDelegate>
{
    
    IBOutlet NSLayoutConstraint *viewY;
}
@end

@implementation FKManagerSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addShownWithY:iPhoneX_Top];
    viewY.constant = (iPhoneX_Top) + topSpacing;
    
    [self setupBackBtnNavBarWithTitle:@"搜索"];
    
    
    self.telText.keyboardType = UIKeyboardTypeNumberPad;
    self.startDateText.inputView = self.datePicker;
    self.endDateText.inputView = self.datePicker;
    self.startDateText.delegate = self;
    self.endDateText.delegate = self;
    self.nameText.delegate = self;
    self.telText.delegate = self;
    
    self.manBtn.selected = YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    textField.text = @"";
    if ([textField isEqual:self.startDateText]) {
        
        self.textFiled = self.startDateText;
    }else{
        
        self.textFiled = self.endDateText;
    }
    return YES;
}


- (IBAction)onSearchBtn:(UIButton *)sender {
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [self showSVPError:@"请检查网络连接"];
        return;
    }
    
    FKParameterModel *model = [[FKParameterModel alloc] init];
    model.school_id = [UserDefaultsTool getSchoolId];
    model.page = @"1";
    model.name = self.nameText.text;
    
    if (self.manBtn.selected) {
        
        model.sex = @"1";
    }else{
        
        model.sex = @"2";
    }
    
    model.visitor_tel = self.telText.text;
    model.srtart_login_time = self.startDateText.text;
    model.end_login_time = self.endDateText.text;
    
    if (self.searchBlock != nil) {
        
        self.searchBlock(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)onManBtn:(UIButton *)sender {
    
    if (self.womanBtn.selected == NO) {
        
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        self.womanBtn.selected = NO;
    }
    
    
}
- (IBAction)onWomanBtn:(UIButton *)sender {
    
    if (self.manBtn.selected == NO) {
        
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        self.manBtn.selected = NO;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    NSLog(@"点击了搜索");
    
    return YES;
    
}

- (void)returnText:(searchBlock)block{
    
    self.searchBlock = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
