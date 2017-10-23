//
//  SGDJViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SGDJViewController.h"
#import "OtherVisiterList.h"
#import "OtherVisiterModel.h"
#import "CallerOrgListViewController.h"
#import "CallerListViewController.h"
#import "OtherVisiterAddViewController.h"
#import "SecuritySGAgree+CoreDataProperties.h"

@interface SGDJViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


{
    UIImagePickerControllerSourceType sourceType;
    BOOL ifSacn;//判断是否已经扫描
    IBOutlet NSLayoutConstraint *viewY;
    IBOutlet NSLayoutConstraint *viewBottom;
    
    IBOutlet NSLayoutConstraint *shownY;
}

@property (strong, nonatomic) UIImage *theNewImg;
@property (strong, nonatomic) SGDJParameterModel *parameterModel;

@end

@implementation SGDJViewController

- (SGDJParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[SGDJParameterModel alloc] init];
        
    }
    return _parameterModel;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ifSacn = NO;
    
    self.visiter_phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    
    
    //随行人员初始化
    [OtherVisiterList sharedInstance].otherVisiterListArr = [NSMutableArray array];
    
    shownY.constant = iPhoneX_Top;
    viewY.constant = (iPhoneX_Top) + 0.5;

    [self setupBackBtnNavBarWithTitle:@"手工登记"];
    
    
    self.visiter_dateTf.inputView = self.datePicker;
    self.textFiled = self.visiter_dateTf;
}

#pragma mark - 选择受访人部门
- (IBAction)onCallerOrgBtn:(UIButton *)sender {
    
    CallerOrgListViewController *VC = [[CallerOrgListViewController alloc] init];
    [VC returnText:^(CallerOrgModel *model) {
        
        self.parameterModel.org_id = model.org_id;
        [self.caller_orgBtn setTitle:model.name forState:UIControlStateNormal];
        [self.caller_nameBtn setTitle:@"--" forState:UIControlStateNormal];
        self.caller_phoneTf.text = @"";
        self.caller_telTf.text = @"";
    }];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 选择受访人
- (IBAction)onCallerNameBtn:(UIButton *)sender {
    
    if (!(self.parameterModel.org_id.length > 0)) {
        
        [self showMBPError:@"请先选择受访人部门"];
        return;
    }
    
    CallerListViewController *VC = [[CallerListViewController alloc] init];
    
    VC.orgId = self.parameterModel.org_id;
    
    [VC returnText:^(CallerModel *model) {
        
        self.parameterModel.caller_id = model.caller_id;
        [self.caller_nameBtn setTitle:model.name forState:UIControlStateNormal];
        self.caller_phoneTf.text = model.mphone;
        self.caller_telTf.text = model.tel;
    }];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 拨打受访人手机号
- (IBAction)onCallerPhoneBtn:(UIButton *)sender {
    
    [self callPhoneNumber:self.caller_phoneTf.text];
}


#pragma mark - 拨打受访人座机
- (IBAction)onCallerTelBtn:(UIButton *)sender {
    
    [self callPhoneNumber:self.caller_telTf.text];
}

- (void)callPhoneNumber:(NSString *)phoneNumber{
    
    if (!(phoneNumber.length > 0)) {
        
        return;
        
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
    
    NSDictionary *dic = [NSDictionary dictionary];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:dic completionHandler:nil];
    
}
#pragma mark - 选择照片
- (IBAction)onHeaderImgBtn:(UIButton *)sender {
    
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            
            picker.delegate = self;
            
            picker.sourceType=sourceType;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                sourceType = UIImagePickerControllerSourceTypeCamera;
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                
                picker.delegate = self;
                
                picker.sourceType=sourceType;
                
                [self presentViewController:picker animated:YES completion:nil];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                
                picker.delegate = self;
                
                picker.sourceType=sourceType;
                
                [self presentViewController:picker animated:YES completion:nil];
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
        
    }
    
}



#pragma mark - 相册选择完成
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.theNewImg = image;
    
    
    [self.visiter_headImBtn setImage:image forState:UIControlStateNormal];
    
}



#pragma mark - 扫描身份证
- (IBAction)onScanIDCardBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    [IDInfoList sharedInstance].idInfo = [[IDInfo alloc] init];
    
    AVCaptureViewController *VC = [[AVCaptureViewController alloc] init];
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        VC.type = 2;
                        MJWeakSelf
                        [VC returnText:^{
                            
                            ifSacn = YES;
                            
                            weakSelf.visiter_nameTf.text = [IDInfoList sharedInstance].idInfo.name;
                            weakSelf.visiter_idcardTf.text = [IDInfoList sharedInstance].idInfo.num;
                        }];
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
            
            
            VC.type = 2;
            MJWeakSelf
            [VC returnText:^{
                
                ifSacn = YES;
                
                weakSelf.visiter_nameTf.text = [IDInfoList sharedInstance].idInfo.name;
                weakSelf.visiter_idcardTf.text = [IDInfoList sharedInstance].idInfo.num;
                
            }];
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

#pragma mark - 编辑随行人员
- (IBAction)onEditOtherVisiterBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    OtherVisiterAddViewController *VC = [[OtherVisiterAddViewController alloc] init];
    [VC returnOtherBlock:^{
        
        if ([OtherVisiterList sharedInstance].otherVisiterListArr.count > 0) {
            
            [self.caller_otherNumBtn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)[OtherVisiterList sharedInstance].otherVisiterListArr.count] forState:UIControlStateNormal];
        }else{
            
            [self.caller_otherNumBtn setTitle:@"0" forState:UIControlStateNormal];
        }
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 放行
- (IBAction)onAgreeBtn:(UIButton *)sender {
    
    if ([self nextOrNo]) {
    
        sender.userInteractionEnabled = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认放行" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            sender.userInteractionEnabled = YES;
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.view endEditing:YES];
            [self postStoreWithSetParameterModelWithStatus:@"3"];
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
}

#pragma mark - 取消
- (IBAction)onCancelBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 放行/拒绝进入-操作前判断
- (BOOL)nextOrNo{
    
    if ([self.caller_orgBtn.currentTitle isEqualToString:@"--"]) {
        
        [self showMBPError:@"请输入受访人部门"];
        return NO;
    }
    
    if ([self.caller_nameBtn.currentTitle isEqualToString:@"--"]) {
        
        [self showMBPError:@"请输入受访人姓名"];
        return NO;
    }
    
    
    UIImage *img = [UIImage imageNamed:@"add_img"];
    if ([self.visiter_headImBtn.currentImage isEqual:img]) {
        
        [self showMBPError:@"请输入来访人照片"];
        
        return NO;
    }
    
    if (! (self.visiter_nameTf.text.length > 0)) {
        
        [self showMBPError:@"请输入来访人姓名"];
        return NO;
    }
    
    if (! (self.visiter_phoneTf.text.length > 0)) {
        
        [self showMBPError:@"请输入来访人电话"];
        return NO;
    }
    if (! (self.visiter_idcardTf.text.length > 0)) {
        
        [self showMBPError:@"请输入来访人身份证号"];
        return NO;
    }
    
    if (ifSacn == NO) {

        [self showMBPError:@"请扫描身份证以确认身份"];
        return NO;
    }
    
    
    if (! (self.visiter_dateTf.text.length > 0)) {
        
        [self showMBPError:@"请输入来访日期"];
        return NO;
    }
    
    return YES;
    
}

#pragma mark - 设置参数，进行网络请求
- (void)postStoreWithSetParameterModelWithStatus:(NSString *)status{

    self.parameterModel.status = status;
    self.parameterModel.visitor_picture = [ImgToBatManager image2DataURL:self.visiter_headImBtn.currentImage];
    self.parameterModel.school_id = [UserDefaultsTool getSchoolId];
    self.parameterModel.security_personnel_id = [UserDefaultsTool getSecurityId];
    self.parameterModel.id_card = self.visiter_idcardTf.text;
    self.parameterModel.id_name = self.visiter_nameTf.text;
    
    if ( [[IDInfoList sharedInstance].idInfo.gender isEqualToString:@"男"]) {
        
        self.parameterModel.id_sex = @"1";
    }else{
        
        self.parameterModel.id_sex = @"2";
    }
    
    self.parameterModel.id_birthday =  [IDInfoList sharedInstance].idInfo.birth;
    self.parameterModel.id_address =  [IDInfoList sharedInstance].idInfo.address;
    
    NSString *a = [IDInfoList sharedInstance].idInfo.start_date;
    NSString *b = [IDInfoList sharedInstance].idInfo.end_date;
    
    self.parameterModel.id_validity_date = [NSString stringWithFormat:@"%@-%@",a,b];
    
    self.parameterModel.id_nation = [IDInfoList sharedInstance].idInfo.nation;
    self.parameterModel.id_release_organ = [IDInfoList sharedInstance].idInfo.issue;
    
    self.parameterModel.is_other_person = @"0";
    
    if([OtherVisiterList sharedInstance].otherVisiterListArr.count > 0){
        
        self.parameterModel.is_other_person = [NSString stringWithFormat:@"%lu",(unsigned long)[OtherVisiterList sharedInstance].otherVisiterListArr.count];
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (OtherVisiterModel *info in [OtherVisiterList sharedInstance].otherVisiterListArr) {
            
            NSDictionary *a = @{
                                @"id_card":info.id_card,
                                @"id_name":info.name,
                                @"id_sex":info.gender,
                                @"id_birthday":info.birthday,
                                @"id_address":info.address,
                                @"id_validity_date":[NSString stringWithFormat:@"%@-%@",info.start_date,info.end_date],
                                @"id_nation":info.nation,
                                @"id_release_organ":info.part
                                };
            [arr addObject:a];
        }
        
        self.parameterModel.other_person_list = [self arrayToJSONString:arr];
    }
    
    self.parameterModel.is_car = @"2";
    
    if (self.visiter_carTf.text.length > 0) {
        
        self.parameterModel.is_car = @"1";
        self.parameterModel.plate_number = self.visiter_carTf.text;
    }
    
    self.parameterModel.visitor_tel = self.visiter_phoneTf.text;
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        MJWeakSelf
        [MyCoreDataManager inserDataWith_CoredatamodelClass:[SecuritySGAgree class] CoredataModel:^(SecuritySGAgree *info) {
        
            info.timeStamp = [StrTool getTimeStamp];
            info.status = weakSelf.parameterModel.status;
            info.visitor_picture = weakSelf.parameterModel.visitor_picture;
            info.school_id = weakSelf.parameterModel.school_id;
            info.security_personnel_id = weakSelf.parameterModel.security_personnel_id;
            info.id_card = weakSelf.parameterModel.id_card;
            info.id_name = weakSelf.parameterModel.id_name;
            info.id_sex = weakSelf.parameterModel.id_sex;
            info.id_birthday = weakSelf.parameterModel.id_birthday;
            info.id_address = weakSelf.parameterModel.id_address;
            info.id_validity_date = weakSelf.parameterModel.id_validity_date;
            info.id_nation = weakSelf.parameterModel.id_nation;
            info.id_release_organ = weakSelf.parameterModel.id_release_organ;
            info.is_other_person = weakSelf.parameterModel.is_other_person;
            info.other_person_list = weakSelf.parameterModel.other_person_list;
            info.is_car = weakSelf.parameterModel.is_car;
            info.plate_number = weakSelf.parameterModel.plate_number;
            info.visitor_tel = weakSelf.parameterModel.visitor_tel;
            info.caller_id = weakSelf.parameterModel.caller_id;
            info.org_id = weakSelf.parameterModel.caller_id;
            [weakSelf showSVPSuccess:@"放行成功，待网络正常时将自动上传"];
            self.fkStatusLa.alpha = 1;
            self.agreeBtn.userInteractionEnabled = YES;
            
            
        } Error:^(NSError *error) {
            
        }];
        
    }else{
        
        [self addLoadingView];
        
        BaseStore *store = [[BaseStore alloc] init];
        [store ifLetGoWithSGDJParameterModel:self.parameterModel Success:^{
            
            [self showSVPSuccess:@"已放行"];
            self.fkStatusLa.alpha = 1;
            self.agreeBtn.userInteractionEnabled = YES;
            
        } Failure:^(NSError *error) {
            
            [self showSVPError:[HttpTool handleError:error]];
            self.agreeBtn.userInteractionEnabled = YES;
        }];
    }
}
#pragma mark - 数组转js格式
- (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
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
