//
//  LFDetailEditViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFDetailEditViewController.h"
#import "CallerOrgListViewController.h"
#import "CallerListViewController.h"
#import "SMIdCardViewController.h"
#import "OtherVisiterModel.h"
#import "OtherVisiterList.h"
#import "OtherVisiterAddViewController.h"
#import "ScanParameterModel.h"
#import "ScanList.h"

@interface LFDetailEditViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UIImagePickerControllerSourceType sourceType;
    
    BOOL goNextFlag;
    
    NSString *partId;//部门id
    
    IBOutlet NSLayoutConstraint *shownY;
    
    IBOutlet NSLayoutConstraint *viewY;
    IBOutlet NSLayoutConstraint *viewBottom;
}

@property (strong, nonatomic) UIImage *theNewImg;

@property (strong, nonatomic) ScanParameterModel *parameterModel;

@end

@implementation LFDetailEditViewController

- (ScanParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[ScanParameterModel alloc] init];
    }
    return _parameterModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lf_telText.keyboardType = UIKeyboardTypeNumberPad;
    
    [IDInfoList sharedInstance].smResult = @"未核实身份证信息";
    self.lf_dateText.inputView = self.datePicker;
    self.textFiled = self.lf_dateText;
    
    [self setupBackBtnNavBarWithTitle:@"来访详情"];
    
    shownY.constant = iPhoneX_Top;
    
    viewY.constant = (iPhoneX_Top) + 0.5;
    
    [self refresh];
}

- (void)refresh{
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    MJWeakSelf
    [store getLFDetailInfoWithVr_id:self.vr_id Success:^(LFDetailModel *model) {
        
        [weakSelf removeLoadingView];
        
        [ScanList sharedInstance].scanModel.vr_id = model.vr_id;
        [ScanList sharedInstance].scanModel.visitor_id = model.visitor_id;
        weakSelf.parameterModel.visitor_id = model.visitor_id;
        
        [weakSelf setUI:model];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
    
}

- (void)setUI:(LFDetailModel *)model{
    
    if (model.visitor_picture.length > 0) {
        
        [self.headerImBtn sd_setImageWithURL:[NSURL URLWithString:model.visitor_picture] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_imgLoading"]];
    }else{
        
        [self.headerImBtn setImage:[UIImage imageNamed:@"add_img"] forState:UIControlStateNormal];
    }
    
    self.lf_nameText.text = model.visitor_name;
    self.lf_telText.text = model.visitor_tel;
    self.lf_idCardText.text = model.visitor_id_card;
    self.lf_dateText.text = model.format_visitor_time;
    
    if ([model.is_car isEqualToString:@"2"]) {
        
        self.lf_carIdText.text  = @"";
    }else{
        
        self.lf_carIdText.text  = model.plate_number;
    }
    
    if ([model.is_other_person isEqualToString:@"0"] || !(model.is_other_person.length > 0) ) {
        
        [self.lf_otherNumBtn setTitle:@"0" forState:UIControlStateNormal];
        
    }else{
        
        [self.lf_otherNumBtn setTitle:model.is_other_person forState:UIControlStateNormal];
    }
    
    [self.sf_peopleBtn setTitle:model.caller_name forState:UIControlStateNormal] ;
    
    [self.sf_partBtn setTitle:model.org_name forState:UIControlStateNormal];
    self.sf_phoneText.text = model.caller_tel;
    self.sf_telText.text = model.caller_mphone;
    
    NSString *str = @"";
    if ([model.visitor_status isEqualToString:@"0"]) {
        
        str = @"受访人未回复";
    
        
    }else if ([model.visitor_status isEqualToString:@"1"]){
        
        str = @"受访人已同意";
        
    }
    self.statusLa.text = str;
    
}



#pragma mark - 选择受访人
- (IBAction)onSelectPeopleBtn:(UIButton *)sender {
    
    if (!(partId.length > 0)) {
        
        [MBProgressHUD showError:@"请先选择受访人部门" toView:self.view];
        return;
    }
    
    CallerListViewController *callerVC = [[CallerListViewController alloc] init];
    
    callerVC.orgId = partId;
    
    [callerVC returnText:^(CallerModel *model) {
        
        [sender setTitle:model.name forState:UIControlStateNormal];
        self.sf_phoneText.text = model.mphone;
        self.sf_telText.text = model.tel;
        
    }];
    [self.navigationController pushViewController:callerVC animated:YES];
    
}

#pragma mark - 选择部门
- (IBAction)onSelectPartBtn:(UIButton *)sender {
    
    CallerOrgListViewController *orgVC = [[CallerOrgListViewController alloc] init];
    
    [orgVC returnText:^(CallerOrgModel *model) {
        
        partId = model.org_id;
        [sender setTitle:model.name forState:UIControlStateNormal];
        [self.sf_peopleBtn setTitle:@"--" forState:UIControlStateNormal];
        self.sf_phoneText.text = @"";
        self.sf_telText.text = @"";
    }];
    
    [self.navigationController pushViewController:orgVC animated:YES];
}

#pragma mark - 选择照片
- (IBAction)onHeaderImBtn:(UIButton *)sender {
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



#pragma mark - 相册选择完成
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.theNewImg = image;
    
    
    [self.headerImBtn setImage:image forState:UIControlStateNormal];
    
}


#pragma mark - 放行
- (IBAction)onLetGoBtn:(UIButton *)sender {
    
    //判断是否继续执行
    if (![self nextOrNo]) {
        
        return;
        
    }
    
    sender.userInteractionEnabled = NO;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认放行" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        sender.userInteractionEnabled = YES;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self postStoreWithSetParameterModelWithStatus:@"3"];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark - 拒绝
- (IBAction)onRefuseBtn:(UIButton *)sender {
    
    
    sender.userInteractionEnabled = NO;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认拒绝" preferredStyle:UIAlertControllerStyleAlert];
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
    
    if ([self.sf_partBtn.currentTitle isEqualToString:@"--"]) {
        
        [self showMBPError:@"请输入受访人部门"];
        return NO;
    }
    
    if ([self.sf_peopleBtn.currentTitle isEqualToString:@"--"]) {
        
        [self showMBPError:@"请输入受访人姓名"];
        return NO;
    }
    
    
    UIImage *img = [UIImage imageNamed:@"add_img"];
    if ([self.headerImBtn.currentImage isEqual:img]) {
        
        [self showMBPError:@"请输入来访人照片"];
        
        return NO;
    }
    
    if (! (self.lf_nameText.text.length > 0)) {
        
        [self showMBPError:@"请输入来访人姓名"];
        return NO;
    }
    
    if (! (self.lf_telText.text.length > 0)) {
        
        [self showMBPError:@"请输入来访人电话"];
        return NO;
    }
    if (! (self.lf_idCardText.text.length > 0)) {
        
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
    
    if (! (self.lf_dateText.text.length > 0)) {
        
        [self showMBPError:@"请输入来访日期"];
        return NO;
    }
    
    return YES;
    
}

#pragma mark - 设置参数，进行网络请求
- (void)postStoreWithSetParameterModelWithStatus:(NSString *)status{
    
    self.parameterModel.vr_id = self.vr_id;
    self.parameterModel.status = status;
    self.parameterModel.visitor_picture = [ImgToBatManager image2DataURL:self.headerImBtn.currentImage];
    self.parameterModel.school_id = [UserDefaultsTool getSchoolId];
    self.parameterModel.security_personnel_id = [UserDefaultsTool getSecurityId];
    self.parameterModel.id_card = self.lf_idCardText.text;
    self.parameterModel.id_name = self.lf_nameText.text;
    
    
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
        
        self.parameterModel.other_person_list = [self arrayToJSONString:arr];
    }
    
    self.parameterModel.is_car = @"2";
    
    if (self.lf_carIdText.text.length > 0) {
        
        self.parameterModel.is_car = @"1";
        self.parameterModel.id_card = self.lf_carIdText.text;
    }
    
    
    self.parameterModel.visitor_tel = self.lf_telText.text;
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    MJWeakSelf
    [store ifLetGoWithParameterModel:self.parameterModel Success:^{
    
        
        if ([status isEqualToString:@"3"]) {
            
        
            [weakSelf showSVPSuccess:@"已放行"];
            weakSelf.loginoutView.alpha = 1;
            
        }
        if ([status isEqualToString:@"5"]) {
            
            
            [weakSelf showSVPSuccess:@"已拒绝"];
            weakSelf.fkStatusLa.alpha = 1;
            weakSelf.fkStatusLa.text = @"拒绝进入";
            weakSelf.fkStatusLa.textColor = [UIColor redColor];
            
        }
    
        if(weakSelf.ifLetGoBlock != nil){
            
            weakSelf.ifLetGoBlock();
        }
        
    } Failure:^(NSError *error) {
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
        weakSelf.agreeGoBtn.userInteractionEnabled = YES;
        weakSelf.refuseGoBtn.userInteractionEnabled = YES;
    }];
    
}


#pragma mark - 数组转js格式
- (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

#pragma mark - 显示错误信息
- (void)showErrorWithTitle:(NSString *)title{
    
    NSString *srt = [NSString stringWithFormat:@"输入%@",title];
    [MBProgressHUD showError:srt toView:self.view];
}




#pragma mark - 身份证扫描
- (IBAction)onScaningBtn:(UIButton *)sender {
    
    [IDInfoList sharedInstance].idInfo = [[IDInfo alloc] init];
    
    AVCaptureViewController *VC = [[AVCaptureViewController alloc] init];
    
    VC.type = 4;
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 添加随行人员
- (IBAction)onAddOtherBtn:(UIButton *)sender {
    
    OtherVisiterAddViewController *VC = [[OtherVisiterAddViewController alloc] init];
    [VC returnOtherBlock:^{
        
        if ([OtherVisiterList sharedInstance].otherVisiterListArr.count > 0) {
            
            [self.lf_otherNumBtn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)[OtherVisiterList sharedInstance].otherVisiterListArr.count] forState:UIControlStateNormal];
        }else{
            
            [self.lf_otherNumBtn setTitle:@"0" forState:UIControlStateNormal];
        }
        
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 给受访人打电话
- (IBAction)onPhoneBtn:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    if (self.sf_phoneText.text.length > 0) {
        
        [self callNum:self.sf_phoneText.text];
    }
    
    [self performSelector:@selector(canSecected) withObject:nil afterDelay:1];
}

#pragma mark - 给受访人打座机
- (IBAction)onTelBtn:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    if (self.sf_telText.text.length > 0) {
        
        [self callNum:self.sf_telText.text];
    }
    
    [self performSelector:@selector(canSecected) withObject:nil afterDelay:1];
}

- (void)canSecected{
    
    self.telBtn.userInteractionEnabled = YES;
    self.phoneBtn.userInteractionEnabled = YES;
}
- (void)callNum:(NSString *)tel{
    
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
    
    NSDictionary *dic = [NSDictionary dictionary];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:dic completionHandler:^(BOOL success) {
        
    }];
}

#pragma mark - 访客登出
- (IBAction)onLoginOutBtn:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认登出" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self loginout];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}

- (void)loginout{
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *vr_id = self.vr_id;
    NSString *schoolId = [UserDefaultsTool getSchoolId];
    NSString *securityId = [UserDefaultsTool getSecurityId];
    
    MJWeakSelf
    [store fkLoginOutWithVr_Id:vr_id andSchoolId:schoolId andSecurityId:securityId Success:^{
        
        if (weakSelf.ifLetGoBlock != nil) {
            
            weakSelf.ifLetGoBlock();
        }
        weakSelf.loginoutView.alpha = 0;
        weakSelf.fkStatusLa.alpha = 1;
        weakSelf.fkStatusLa.text = @"访客已离开";
        
        [weakSelf showSVPSuccess:@"成功登出"];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
}

- (void)returnMyBlock:(ifLetGoBlock)block{
    
    self.ifLetGoBlock = block;
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
