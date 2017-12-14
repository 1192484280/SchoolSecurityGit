//
//  LFDetailViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFDetailViewController.h"
#import "OtherDetailViewController.h"
#import "SMIdCardViewController.h"
#import "ScanParameterModel.h"
#import "OtherVisiterList.h"
#import "OtherDetailModel.h"
#import "OtherVisiterModel.h"
#import "EnlargeImgViewController.h"
#import "LFManager+CoreDataProperties.h"
#import "LFDetail+CoreDataProperties.h"
#import "FKDC+CoreDataProperties.h"

@interface LFDetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

{
    UIImagePickerControllerSourceType sourceType;
    
    IBOutlet NSLayoutConstraint *shownY;
    IBOutlet NSLayoutConstraint *viewY;
    IBOutlet NSLayoutConstraint *viewBottom;
}
@property (strong, nonatomic) NSMutableDictionary *dic;

@property (strong, nonatomic) UIImage *theNewImg;

@property (strong, nonatomic) ScanParameterModel *parameterModel;

@end

@implementation LFDetailViewController

- (ScanParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[ScanParameterModel alloc] init];
    }
    return _parameterModel;
}

- (NSMutableDictionary *)dic{
    
    if (!_dic) {
        
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"来访详情"];
 
    shownY.constant = iPhoneX_Top;
    viewY.constant = (iPhoneX_Top) + 0.5;
    
    [self refresh];
    
    //图像添加点击事件（手势方法）
    self.lf_photoImg.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1;
    //手指数
    PrivateLetterTap.numberOfTapsRequired = 1;
    //tap次数
    PrivateLetterTap.delegate= self;
    self.lf_photoImg.contentMode = UIViewContentModeScaleToFill;
    [self.lf_photoImg addGestureRecognizer:PrivateLetterTap];
}


#pragma mark ---"头像"点击触发的方法，完成跳转
- (void)tapAvatarView:(UITapGestureRecognizer *)gesture {
    
    EnlargeImgViewController *VC = [[EnlargeImgViewController alloc] init];
    
    VC.img = self.lf_photoImg.image;
    
    CATransition *animation = [CATransition animation];
    //    rippleEffect
    animation.type = @"rippleEffect";
    animation.subtype = @"fromBottom";
    animation.duration=  1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)refresh{
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    MJWeakSelf
    [store getLFDetailInfoWithVr_id:self.vr_id Success:^(LFDetailModel *model) {
        
        [weakSelf removeLoadingView];

        [weakSelf setUI:model];
        
    } Failure:^(NSError *error) {
        

        [weakSelf showSVPError:[HttpTool handleError:error]];
        
    }];
    
}

- (void)setUI:(LFDetailModel *)model{
    
    if (model.visitor_picture.length > 0) {
        
        [self.lf_photoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IP,model.visitor_picture]] placeholderImage:[UIImage imageNamed:@"icon_imgLoading"]];
        
    }else{
        
        self.lf_photoImg.image = [UIImage imageNamed:@"add_img"];
    }
    
    self.lf_nameLa.text = model.visitor_name;
    self.lf_telLa.text = model.visitor_tel;
    self.lf_idCardLa.text = model.visitor_id_card;
    self.lf_dateLa.text = model.format_visitor_time;
    
    if ([model.is_car isEqualToString:@"2"]) {
     
        self.lf_carIDLa.text  = @"没有登记车辆";
    }else{
        
        self.lf_carIDLa.text  = model.plate_number;
    }
    
    self.lf_otherBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    if ([model.is_other_person isEqualToString:@"0"] || !(model.is_other_person.length > 0) ) {
        
        [self.lf_otherBtn setTitle:@"没有随行人员" forState:UIControlStateNormal];
        
    }else{
        
        [self.lf_otherBtn setTitle:model.is_other_person forState:UIControlStateNormal];
    }

    self.sf_name.text = model.caller_name;
    self.sf_partLa.text = model.org_name;
    self.sf_phoneLa.text = model.caller_tel;
    self.sf_telLa.text = model.caller_mphone;

    NSString *str = @"";
    if ([model.visitor_status isEqualToString:@"2"]){
        
        str = @"受访人已拒绝";
        
        self.statusLa.alpha = 1;
        
        
    }else if ([model.visitor_status isEqualToString:@"3"]){
        
        
        self.fkLoginoutBtn.alpha = 1;
        
        
    }else if ([model.visitor_status isEqualToString:@"4"]){
        
        str = @"访客已离开";
        
        self.statusLa.alpha = 1;
        
    }else{
        
        str = @"拒绝进入";
        
        self.statusLa.alpha = 1;
        
    }
    self.statusLa.text = str;
    
}

#pragma mark - 点击其他随心人员
- (IBAction)onLfOtherBtn:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"没有随行人员"]) {
        
        return;
    }
    
    OtherDetailViewController *VC = [[OtherDetailViewController alloc] init];
    VC.vr_id = self.vr_id;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 打手机
- (IBAction)onPhoneBtn:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    if (self.sf_phoneLa.text.length > 0) {
        
        [self callNum:self.sf_phoneLa.text];
    }
    
    [self performSelector:@selector(canSecected) withObject:nil afterDelay:1];
}

#pragma mark - 打座机
- (IBAction)onTelBtn:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    if (self.sf_telLa.text.length > 0) {
        
        [self callNum:self.sf_telLa.text];
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
- (IBAction)onFKLoginoutBtn:(UIButton *)sender {
    
    NSString *msg = @"确认登出";
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        msg = @"当前网络不畅，执行操作后数据将待网络正常时上传";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self loginout];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

- (void)loginout{
    
    MJWeakSelf
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[FKDC class] where:[NSString stringWithFormat:@"vr_id = '%@'",self.vr_id] Alldata_arr:^(NSArray *coredataModelArr) {
           
            if (!(coredataModelArr.count > 0)) {
                
                [MyCoreDataManager inserDataWith_CoredatamodelClass:[FKDC class] CoredataModel:^(FKDC *info) {
                    
                    info.vr_id = weakSelf.vr_id;
                    info.schoolId = [UserDefaultsTool getSchoolId];
                    info.securityId = [UserDefaultsTool getSecurityId];
                    
                    [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[LFManager class] where:[NSString stringWithFormat:@"vr_id = '%@'",self.vr_id] result:^(BOOL isResult) {
                     
                        if (weakSelf.loginoutBlock != nil) {
                            
                            weakSelf.loginoutBlock();
                        }
                        
                     weakSelf.fkLoginoutBtn.alpha = 0;
                     weakSelf.statusLa.alpha = 1;
                     weakSelf.statusLa.text = @"访客已离开";
                     
                     [weakSelf showSVPSuccess:@"成功登出，待网络正常时将自动上传"];
                     
                     
                    [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[LFDetail class] where:[NSString stringWithFormat:@"vr_id = '%@'",weakSelf.vr_id] result:^(BOOL isResult) {
                        
                    } Error:^(NSError *error) {
                        
                    }];
                        
                     } Error:^(NSError *error) {
                     
                     }];
                    
                } Error:^(NSError *error) {
                    
                }];
            }
        } Error:^(NSError *error) {
            
        }];
        
        
        
        return;
    }
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *vr_id = self.vr_id;
    NSString *schoolId = [UserDefaultsTool getSchoolId];
    NSString *securityId = [UserDefaultsTool getSecurityId];
    
    [store fkLoginOutWithVr_Id:vr_id andSchoolId:schoolId andSecurityId:securityId Success:^{
        
        if (weakSelf.loginoutBlock != nil) {
            
            weakSelf.loginoutBlock();
        }
        weakSelf.fkLoginoutBtn.alpha = 0;
        weakSelf.statusLa.alpha = 1;
        weakSelf.statusLa.text = @"访客已离开";
        
        [weakSelf showSVPSuccess:@"成功登出"];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
}


#pragma mark - 点击头像
- (IBAction)onHeaderBtn:(UIButton *)sender {
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
    
    self.lf_photoImg.image = image;
    
}

#pragma mark - 图片转bat64
- (NSString *) image2DataURL: (UIImage *) image

{
    
    NSData *imageData = nil;
    
    NSString *mimeType = nil;
    
    
    
    if ([self imageHasAlpha: image]) {
        
        imageData = UIImagePNGRepresentation(image);
        
        mimeType = @"image/png";
        
    } else {
        
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        
        mimeType = @"image/jpeg";
        
    }
    
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
    
    
    
}

- (BOOL) imageHasAlpha: (UIImage *) image
{
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    
    return (alpha == kCGImageAlphaFirst ||
            
            alpha == kCGImageAlphaLast ||
            
            alpha == kCGImageAlphaPremultipliedFirst ||
            
            alpha == kCGImageAlphaPremultipliedLast);
    
}

- (void)returnMyBlock:(loginoutBlock)block{
    
    self.loginoutBlock = block;
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
