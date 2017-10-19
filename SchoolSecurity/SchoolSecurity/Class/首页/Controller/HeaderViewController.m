//
//  HeaderViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/16.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "HeaderViewController.h"
#import "LoginViewController.h"
#import "FKDJViewController.h"
#import "LFManagerViewController.h"
#import "BlackManagerViewController.h"
#import "FKManagerViewController.h"
#import "XGJLViewController.h"
#import "PersonInfoViewController.h"
#import "PersonList.h"
#import "EnlargeImgViewController.h"
#import "SettingViewController.h"

@interface HeaderViewController ()<UIGestureRecognizerDelegate>
{
    
    IBOutlet NSLayoutConstraint *loginViewY;
    IBOutlet UIView *moreView;
    IBOutlet NSLayoutConstraint *moreBottom;
}

@end

@implementation HeaderViewController

- (void)setNavBar{
    
    self.title = @"安保终端";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_setting" selectedImageName:@"icon_navSticon_settingart" target:self action:@selector(onClickSet)];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - 设置
- (void)onClickSet{
    
    NSString *securityId = [UserDefaultsTool getSecurityId];
    
    if (securityId.length > 0) {
        
        SettingViewController *setVC = [[SettingViewController alloc] init];
        
        [setVC returnBlock:^{
           
            [self.nameBtn setTitle:@"请登录" forState:UIControlStateNormal];
            [self.telBtn setTitle:@"欢迎使用微信访客系统" forState:UIControlStateNormal];
            self.headerIm.image = [UIImage imageNamed:@"add_img"];
            
        }];
        
        [self.navigationController pushViewController:setVC animated:YES];
    }else{
        
        [self goLoginBlock:^{
            
            [self refreshUI];
        }];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loginViewY.constant = iPhoneX_Top ;
    
    moreBottom.constant = iPhoneX_Bottom;
    
    self.view.backgroundColor = VIEWCOLOR;
    
    [self setNavBar];
    
    [self addShownWithY:iPhoneX_Top];
    
    [self setUI];
    
    //图像添加点击事件（手势方法）
    self.headerIm.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1;
    //手指数
    PrivateLetterTap.numberOfTapsRequired = 1;
    //tap次数
    PrivateLetterTap.delegate= self;
    self.headerIm.contentMode = UIViewContentModeScaleToFill;
    [self.headerIm addGestureRecognizer:PrivateLetterTap];
    
    
}

#pragma mark ---"头像"点击触发的方法，完成跳转 
- (void)tapAvatarView:(UITapGestureRecognizer *)gesture {
    
    EnlargeImgViewController *VC = [[EnlargeImgViewController alloc] init];
    
    VC.img = self.headerIm.image;
    
    CATransition *animation = [CATransition animation];
    //    rippleEffect
    animation.type = @"rippleEffect";
    animation.subtype = @"fromBottom";
    animation.duration=  1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}



- (void)setUI{
    
    NSString *sectid = [UserDefaultsTool getSecurityId];
    
    if (sectid.length > 0) {
        
        //获取个人信息
        [self refreshUI];
        
    }else{
        
        self.headerIm.image = [UIImage imageNamed:@"add_img"];
        [self.nameBtn setTitle:@"请登录" forState:UIControlStateNormal];
        [self.telBtn setTitle:@"欢迎使用微信访客系统" forState:UIControlStateNormal];
        
    }
}


#pragma mark - 访客登记
- (IBAction)goFKDJ:(UIButton *)sender {
    
    NSString *securityId = [UserDefaultsTool getSecurityId];
    if (securityId.length > 0) {
        
        FKDJViewController *VC = [[FKDJViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        
        MJWeakSelf
        [self goLoginBlock:^{
            
            [weakSelf refreshUI];
        }];
    }
    
}

#pragma mark - 来访管理
- (IBAction)goLFManager:(UIButton *)sender {
    
    NSString *securityId = [UserDefaultsTool getSecurityId];
    if (securityId.length > 0) {
        
        LFManagerViewController *VC = [[LFManagerViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        
        MJWeakSelf
        [self goLoginBlock:^{
            
            [weakSelf refreshUI];
        }];
    }
    
}

#pragma mark - 黑名单管理
- (IBAction)goBlackList:(UIButton *)sender {
    
    NSString *securityId = [UserDefaultsTool getSecurityId];
    if (securityId.length > 0) {
        
        BlackManagerViewController *VC = [[BlackManagerViewController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        
        MJWeakSelf
        [self goLoginBlock:^{
            
            [weakSelf refreshUI];
        }];
    }
}


#pragma mark - 访客管理
- (IBAction)goFKManager:(UIButton *)sender {
    
    NSString *securityId = [UserDefaultsTool getSecurityId];
    if (securityId.length > 0) {
        
        FKManagerViewController *VC = [[FKManagerViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        
        MJWeakSelf
        [self goLoginBlock:^{
            
            [weakSelf refreshUI];
        }];
    }
    
}

#pragma mark - 巡更记录
- (IBAction)goXGJL:(UIButton *)sender {
    
    NSString *securityId = [UserDefaultsTool getSecurityId];
    if (securityId.length > 0) {
        
        XGJLViewController *VC = [[XGJLViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        
        MJWeakSelf
        [self goLoginBlock:^{
            
            [weakSelf refreshUI];
        }];
    }
    
}


#pragma mark - 点击登录
- (IBAction)onLogin:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"请登录"] || [sender.titleLabel.text isEqualToString:@"欢迎使用微信访客系统"] ) {
        
        MJWeakSelf
        [self goLoginBlock:^{
            
            [weakSelf refreshUI];
        }];
        
        
    }else{
        
        //跳转个人信息
        PersonInfoViewController *VC = [[PersonInfoViewController alloc] init];
        
        [VC returnMyBlock:^{
            
            [self refreshUI];
        }];
        
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


- (void)refreshUI{
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *school_id = [UserDefaultsTool getSchoolId];
    NSString *security_personnel_id = [UserDefaultsTool getSecurityId];
    
    MJWeakSelf
    
    [store getPersonInfoWithSchoolId:school_id andSecurityId:security_personnel_id Success:^{
        
        NSString *img = [NSString stringWithFormat:@"%@/%@",IP,[PersonList sharedInstance].personModel.headimg];
        
        [self.headerIm sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"add_img"]];
        
        if ([PersonList sharedInstance].personModel.name.length > 0) {
            
            [weakSelf.nameBtn setTitle:[PersonList sharedInstance].personModel.name forState:UIControlStateNormal];
        }else{
            
            [weakSelf.nameBtn setTitle:@"填写用户名" forState:UIControlStateNormal];
        }
        
        if ([PersonList sharedInstance].personModel.tel.length > 0) {
            
            [weakSelf.telBtn setTitle:[PersonList sharedInstance].personModel.mphone forState:UIControlStateNormal];
        }else{
            
            [weakSelf.telBtn setTitle:@"填写电话号" forState:UIControlStateNormal];
        }
        
        [UserDefaultsTool setObj:weakSelf.nameBtn.currentTitle andKey:@"user_name"];
        [UserDefaultsTool setObj:weakSelf.telBtn.currentTitle andKey:@"user_tel"];
        
    }Failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[HttpTool handleError:error]];
    }];
    
}



- (IBAction)onHidenBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
            sender.transform = CGAffineTransformMakeRotation(M_PI);
            moreView.y = CGRectGetMaxY(self.fkdjLa.frame)+25;
            
        } completion:nil];
        
    }else{
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
            
            sender.transform = CGAffineTransformIdentity;
            moreView.y = ScreenHeight;
            
        } completion:nil];
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
