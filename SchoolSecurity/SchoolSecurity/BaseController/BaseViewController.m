//
//  BaseViewController.m
//  ZENWork
//
//  Created by zhangming on 17/3/30.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (UIDatePicker *)datePicker{
    
    if (!_datePicker) {
        
        _datePicker=[[UIDatePicker alloc]init];
        [_datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        _datePicker.datePickerMode=UIDatePickerModeDate;
    }
    return _datePicker;
}

-(void)dateChanged:(UIDatePicker *)picker{
    
    NSDate *date = picker.date;
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    
    [format setTimeStyle:NSDateFormatterShortStyle];
    
    [format setDateFormat:@"YYYY/MM/dd"];
    NSString *a = [format stringFromDate:date];
    self.textFiled.text = a;
    
}


//- (void)viewWillDisappear:(BOOL)animated{
//    
//    [SVProgressHUD dismiss];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = VIEWCOLOR;
    
}


#pragma mark - 带返回的navBar
- (void)setupBackBtnNavBarWithTitle:(NSString *)title
{
    self.title = title;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" selectedImageName:@"icon_back_normal" target:self action:@selector(back)];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self removeLoadingView];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self preferredStatusBarStyle];
        
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self removeLoadingView];
}
/*
- (LoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        _loadingView.center = self.view.center;
    }
    return _loadingView;
}
 */
#pragma mark - 加载loading
- (void)addLoadingView{
    
    [SVProgressHUD show];
}

#pragma mark - 移除loadingview
- (void)removeLoadingView{
    
    [SVProgressHUD dismiss];
}
#pragma mark - 跳到登陆页面
- (void)goLoginBlock:(void(^)())block{
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC returnLoginBlock:^{
        block();
    }];
    
    [self.navigationController pushViewController:loginVC animated:YES];
}


#pragma mark - 阴影
- (void)addShownWithY:(CGFloat)y{
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth, 10)];
    im.image = [UIImage imageNamed:@"icon_shown"];
    
    [self.view addSubview:im];
}


#pragma mark - MBProgress展示错误信息
- (void)showMBPError:(NSString *)msg{
    
    [MBProgressHUD showError:msg toView:self.view];
}

#pragma mark - SVP展示错误信息
- (void)showSVPError:(NSString *)msg{
    
    [SVProgressHUD showErrorWithStatus:msg];
    [self performSelector:@selector(svpDismiss) withObject:nil afterDelay:2];
}

- (void)svpDismiss{
    
    [SVProgressHUD dismiss];
}
#pragma mark - SVP展示成功信息
- (void)showSVPSuccess:(NSString *)msg{
    
    [SVProgressHUD showSuccessWithStatus:msg];
    [self performSelector:@selector(svpDismiss) withObject:nil afterDelay:2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
