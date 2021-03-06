//
//  ScanedViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ScanedViewController.h"
#import "ScanList.h"
#import "CallerListViewController.h"
#import "CallerOrgListViewController.h"
#import "OtherVisiterAddViewController.h"
#import "OtherVisiterList.h"
#import "SMIdCardViewController.h"
#import "ScanParameterModel.h"
#import "OtherVisiterModel.h"
#import "SecurityScanAgree+CoreDataProperties.h"
#import "LookOtherCallerViewController.h"

@interface ScanedViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    NSString *orgId;

    UIImagePickerControllerSourceType sourceType;
    
    IBOutlet NSLayoutConstraint *shownY;
    
    IBOutlet NSLayoutConstraint *viewY;
    
}


@property (strong, nonatomic) ScanParameterModel *parameterModel;
@end

@implementation ScanedViewController

- (ScanParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[ScanParameterModel alloc] init];
    }
    return _parameterModel;
}


#pragma mark - 禁止侧滑，避免跳到扫描页
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}


-(void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.visiter_phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    
    [IDInfoList sharedInstance].smResult = @"未核实身份证信息";
    
    //随行人员初始化
    [OtherVisiterList sharedInstance].otherVisiterListArr = [NSMutableArray array];
    
    shownY.constant = iPhoneX_Top;
    viewY.constant = (iPhoneX_Top) + 0.5;
    
    [self setupBackBtnNavBarWithTitle:@"访客登记"];
    
    [self setUI];
    
    
    
}

- (void)setUI{
    
    ScanModel *model = [ScanList sharedInstance].scanModel;
    
    
    self.parameterModel.vr_id = model.vr_id;
    self.parameterModel.visitor_id = model.visitor_id;
    self.parameterModel.school_id = [UserDefaultsTool getSchoolId];
    self.parameterModel.security_personnel_id = [UserDefaultsTool getSecurityId];
    
    if (model.caller_name.length > 0) {
        
        [self.caller_nameBtn setTitle:model.caller_name forState:UIControlStateNormal];
    }
    
    if (model.org_name.length > 0) {
        
        [self.caller_orgBtn setTitle:model.org_name forState:UIControlStateNormal];
    }
    
    
    self.caller_phoneTf.text = model.caller_mphone;
    self.caller_telTf.text = model.caller_tel;
    
    
    self.visiter_nameTf.text = model.visitor_name;
    self.visiter_phoneTf.text = model.visitor_tel;
    self.visiter_idcardTf.text = model.visitor_id_card;
    self.visiter_dateTf.text = model.format_visitor_time;
    
    if (![model.is_car isEqualToString:@"0"]) {
        
        self.visiter_carTf.text = model.plate_number;
    }
    
    if([model.visitor_status isEqualToString:@"0"]){
        
        self.statusLa.text = @"受访人未回复";
        
        
    }else if ([model.visitor_status isEqualToString:@"1"]){
        
        self.statusLa.text = @"受访人同意";
        
    }else if([model.visitor_status isEqualToString:@"2"]){
        
        self.fkStatus.alpha = 1;
        self.fkStatus.text = @"受访人已拒绝";
        self.fkStatus.textColor = [UIColor redColor];

    }else if([model.visitor_status isEqualToString:@"3"]){
        
        self.fkStatus.alpha = 1;
        self.fkStatus.text = @"访客已进入";
        self.fkStatus.textColor = [UIColor greenColor];
        
    }
}

#pragma mark - 选择受访人部门
- (IBAction)onCallerOrgBtn:(UIButton *)sender {
    
    CallerOrgListViewController *VC = [[CallerOrgListViewController alloc] init];
    [VC returnText:^(CallerOrgModel *model) {
        
        orgId = model.org_id;
        [self.caller_orgBtn setTitle:model.name forState:UIControlStateNormal];
        [self.caller_nameBtn setTitle:@"--" forState:UIControlStateNormal];
        self.caller_phoneTf.text = @"";
        self.caller_telTf.text = @"";
    }];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 选择受访人
- (IBAction)onCallerNameBtn:(UIButton *)sender {
    
    if (!(orgId.length > 0)) {
        
        [self showMBPError:@"请先选择受访人部门"];
        return;
    }
    
    CallerListViewController *VC = [[CallerListViewController alloc] init];
    
    VC.orgId = orgId;
    
    [VC returnText:^(CallerModel *model) {
        
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
    
    
    UIImage *img = [ImageTool imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
    
    [self.visiter_headImBtn setImage:img forState:UIControlStateNormal];
    

}




#pragma mark - 扫描身份证
- (IBAction)onScanIDCardBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    [IDInfoList sharedInstance].idInfo = [[IDInfo alloc] init];
    
    AVCaptureViewController *VC = [[AVCaptureViewController alloc] init];
    
    VC.type = 1;
    
    [self.navigationController pushViewController:VC animated:YES];
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
    
    if (![self nextOrNo]) {
     
        
        return;
    }
    

    sender.userInteractionEnabled = NO;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定放行？放行后系统将自动生成访问记录" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        sender.userInteractionEnabled = YES;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self postStoreWithSetParameterModelWithStatus:@"3"];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

#pragma mark - 拒绝放行
- (IBAction)onRefuseBtn:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定拒绝？拒绝后系统将自动生成访问记录" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        sender.userInteractionEnabled = YES;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self postStoreWithSetParameterModelWithStatus:@"5"];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
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
    
    if ([[IDInfoList sharedInstance].smResult isEqualToString:@"未核实身份证信息"]) {
        
        [self showMBPError:@"请扫描身份证以确认身份"];

        return NO;
    }
    
    
    if (![[IDInfoList sharedInstance].smResult isEqualToString:@"扫描身份证信息与绑定身份证信息一致"]) {
        
        [self showSVPError:[IDInfoList sharedInstance].smResult];
        
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
    
    self.parameterModel.id_birthday = [IDInfoList sharedInstance].idInfo.birth;
    self.parameterModel.id_address = [IDInfoList sharedInstance].idInfo.address;

    self.parameterModel.id_validity_date = [NSString stringWithFormat:@"%@-%@",[IDInfoList sharedInstance].idInfo.start_date,[IDInfoList sharedInstance].idInfo.end_date];
    
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
        
        self.parameterModel.other_person_list = [StrTool arrayToJSONString:arr];
    }
    
    self.parameterModel.is_car = @"2";
    
    if (self.visiter_carTf.text.length > 0) {
        
        self.parameterModel.is_car = @"1";
        self.parameterModel.plate_number = self.visiter_carTf.text;
    }
    

    self.parameterModel.visitor_tel = self.visiter_phoneTf.text;
    
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        MJWeakSelf
        [MyCoreDataManager inserDataWith_CoredatamodelClass:[SecurityScanAgree class] CoredataModel:^(SecurityScanAgree *info) {
            
            info.vr_id = weakSelf.parameterModel.vr_id;
            info.visitor_id = weakSelf.parameterModel.visitor_id;
            info.school_id = weakSelf.parameterModel.school_id;
            info.security_personnel_id = weakSelf.parameterModel.security_personnel_id;
            info.status = weakSelf.parameterModel.status;
            info.id_card = weakSelf.parameterModel.id_card;
            info.id_name = weakSelf.parameterModel.id_name;
            info.id_sex = weakSelf.parameterModel.id_sex;
            info.id_birthday = weakSelf.parameterModel.id_birthday;
            info.id_address = weakSelf.parameterModel.id_address;
            info.id_validity_date = weakSelf.parameterModel.id_validity_date;
            info.id_nation = weakSelf.parameterModel.id_nation;
            info.id_release_organ = weakSelf.parameterModel.id_release_organ;
            info.is_other_person = weakSelf.parameterModel.is_other_person;
            info.is_car = weakSelf.parameterModel.is_car;
            info.visitor_picture = weakSelf.parameterModel.visitor_picture;
            info.visitor_tel = weakSelf.parameterModel.visitor_tel;
            info.other_person_list = weakSelf.parameterModel.other_person_list;
            info.plate_number = weakSelf.parameterModel.plate_number;
            
            NSString *str = @"";
            NSString *str2 = @"";
            UIColor *color = [UIColor blackColor];
            
            if ([status isEqualToString:@"3"]) {
                
                str = @"已放行，待网络正常时将自动上传";
                str2 = @"访客已进入";
                
            }
            if ([status isEqualToString:@"5"]) {
                
                str = @"已拒绝，待网络正常时将自动上传";
                str2 = @"受访人拒绝";
                color = [UIColor redColor];
            }
            
            [self showSVPSuccess:str];
            
            weakSelf.fkStatus.alpha = 1;
            weakSelf.fkStatus.text = str2;
            weakSelf.fkStatus.textColor = color;
            
            
        } Error:^(NSError *error) {
            
        }];
        
    }else{
        
        [self addLoadingView];
        BaseStore *store = [[BaseStore alloc] init];
        
        MJWeakSelf
        [store ifLetGoWithParameterModel:self.parameterModel Success:^{
            
            NSString *str = @"";
            NSString *str2 = @"";
            UIColor *color = [UIColor blackColor];
            
            if ([status isEqualToString:@"3"]) {
                
                str = @"已放行";
                str2 = @"访客已进入";
                
            }
            if ([status isEqualToString:@"5"]) {
                
                str = @"已拒绝";
                str2 = @"受访人拒绝";
                color = [UIColor redColor];
            }
            
            [weakSelf showSVPSuccess:str];
            
            weakSelf.fkStatus.alpha = 1;
            weakSelf.fkStatus.text = str2;
            weakSelf.fkStatus.textColor = color;
            
        } Failure:^(NSError *error) {
            
            [weakSelf showSVPError:[HttpTool handleError:error]];
            weakSelf.agreeBtn.userInteractionEnabled = YES;
            weakSelf.refuseBtn.userInteractionEnabled = YES;
        }];
    }
    
}


#pragma mark - 查看随行人员
- (IBAction)onOtherCallerBtn:(UIButton *)sender {
    
    if (!([OtherVisiterList sharedInstance].otherVisiterListArr.count > 0)) {
        
        return;
    }
    
    LookOtherCallerViewController *VC = [[LookOtherCallerViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)back{
    
    UIViewController *viewCtl = self.navigationController.viewControllers[1];
    
    [self.navigationController popToViewController:viewCtl animated:YES];
    
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
