//
//  XGTableViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGTableViewController.h"
#import "XGTableList.h"

@interface XGTableViewController ()
{
    
    
    IBOutlet NSLayoutConstraint *viewTop;
}
@end

@implementation XGTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"巡更表单"];
    
    [self addShownWithY:iPhoneX_Top];
    
    viewTop.constant = iPhoneX_Top + topSpacing;
    
    [self setModel];
}

- (void)setModel{
    
    self.nameLa.text = [XGTableList sharedInstance].xgTableModel.name;
}
- (void)back{
    
    [SVProgressHUD dismiss];
    UIViewController *viewCtl = self.navigationController.viewControllers[2];
    
    [self.navigationController popToViewController:viewCtl animated:YES];
}

- (IBAction)onSureBtn:(UIButton *)sender {
    
    [self addLoadingView];
    
    sender.userInteractionEnabled = NO;
    BaseStore *store = [[BaseStore alloc] init];
    NSString *ps_id = [XGTableList sharedInstance].xgTableModel.ps_id;
    NSString *note = self.noteText.text;
    NSString *p_id = [XGTableList sharedInstance].p_id;
    NSString *securityId = [UserDefaultsTool getSecurityId];
    
    MJWeakSelf
    [store addXGPointWithPs_id:ps_id andSecurityId:securityId andP_id:p_id andNote:note Success:^{
        sender.userInteractionEnabled = YES;
        
        
        [weakSelf showSVPSuccess:@"扫描点上传成功"];
        [weakSelf performSelector:@selector(back) withObject:nil afterDelay:1];
    } Failure:^(NSError *error) {
       
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
        sender.userInteractionEnabled = YES;
    }];
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
