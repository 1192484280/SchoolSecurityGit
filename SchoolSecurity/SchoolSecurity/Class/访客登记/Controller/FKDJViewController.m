//
//  FKDJViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "FKDJViewController.h"
#import "ScaningViewController.h"
#import "SGDJViewController.h"

@interface FKDJViewController ()

{
    NSString *id_card;
    IBOutlet NSLayoutConstraint *viewY;
    IBOutlet NSLayoutConstraint *viewBottom;
}
@end

@implementation FKDJViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self addShownWithY:iPhoneX_Top];
    
    viewY.constant = iPhoneX_Top + topSpacing;
    viewBottom.constant = iPhoneX_Bottom;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"访客登记"];
    
}

#pragma mark - 扫描登记
- (IBAction)onSMDJBtn:(UIButton *)sender{
    
    [IDInfoList sharedInstance].idInfo = [[IDInfo alloc] init];
    
    ScaningViewController *VC = [[ScaningViewController alloc] init];
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.navigationController pushViewController:VC animated:YES];
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            
            
            [self.navigationController pushViewController:VC animated:YES];
            
        } else if (status == AVAuthorizationStatusDenied) { //
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"摄像头未开启" message:@"开启摄像头，才可以进行扫描" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSString * urlStr = @"App-Prefs:root=com.youjiesi.SecurityManager";
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) { if (iOS10) {
                    
                    //iOS10.0以上 使用的操作
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
                } else {
                    //iOS10.0以下 使用的操作
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                }
                }
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

#pragma mark - 手工登记
- (IBAction)onSGDJBtn:(UIButton *)sender{
    
    [IDInfoList sharedInstance].idInfo = [[IDInfo alloc] init];
    
    SGDJViewController *VC = [[SGDJViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma mark - 登出
- (IBAction)onLoginOutBtn:(UIButton *)sender{
    
    [IDInfoList sharedInstance].idInfo = [[IDInfo alloc] init];
    
    AVCaptureViewController *VC = [[AVCaptureViewController alloc] init];
    VC.type = 3;
    [self.navigationController pushViewController:VC animated:YES];
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
