//
//  SMIdCardViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/30.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SMIdCardViewController.h"
#import "SMIdCardCell.h"
#import "ScanList.h"

@interface SMIdCardViewController ()<UITableViewDelegate,UITableViewDataSource,SMIdCardCellDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *ListArr;

@end

@implementation SMIdCardViewController

- (NSArray *)ListArr{
    
    if (!_ListArr) {
        
        _ListArr = @[@"姓名",@"身份证号",@"性别",@"民族",@"出生日期",@"住址",@"签发机关",@"有效日期"];
    }
    return _ListArr;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5, ScreenWidth, ScreenHeight - (iPhoneX_Top)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.sectionHeaderHeight = groupSectionFooterHeight;
        _tableView.sectionFooterHeight = groupSectionHeaderHeight;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, topSpacing)];
    
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"来访人身份信息"];
    
    [self addShownWithY:iPhoneX_Top];
    
    [self.view addSubview:self.tableView];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 8;
    }else{
        
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMIdCardCell *cell = [SMIdCardCell tempWithTableView:tableView andIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str = @"";
    if (indexPath.row == 0) {
        
        str = [IDInfoList sharedInstance].idInfo.name;
    }else if (indexPath.row == 1){
        
        str = [IDInfoList sharedInstance].idInfo.num;
    }else if (indexPath.row == 2){
        
        str = [IDInfoList sharedInstance].idInfo.gender;
    }else if (indexPath.row == 3){
        
        str = [IDInfoList sharedInstance].idInfo.nation;
    }else if (indexPath.row == 4){
        
        str = [IDInfoList sharedInstance].idInfo.birth;
    }else if (indexPath.row == 5){
        
        str = [IDInfoList sharedInstance].idInfo.address;
    }else if (indexPath.row == 6){
        
        str = [IDInfoList sharedInstance].idInfo.issue;
    }else if (indexPath.row == 7){
        
        str = [NSString stringWithFormat:@"%@-%@",[IDInfoList sharedInstance].idInfo.start_date,[IDInfoList sharedInstance].idInfo.end_date];
    }
    
    [cell reciveInfoWithTitle:self.ListArr[indexPath.row] andInfo:str];
    cell.delegate = self;
    return cell;
}


#pragma mark - SMIdCardCellDelegate
- (void)onSureBtn{
    
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [IDInfoList sharedInstance].smResult = @"扫描身份证信息与绑定身份证信息一致";
        
        //判断身份证号是否与扫描二维码获得的一致
        if (![[IDInfoList sharedInstance].idInfo.num isEqualToString:[ScanList sharedInstance].scanModel.visitor_id_card]) {
            
            [IDInfoList sharedInstance].smResult = @"扫描身份证信息与绑定身份证信息不一致";
            
            return;
        }
        
        //判断身份证是否属于黑名单
        NSString *a;
        if ([a isEqualToString:@"属于黑名单"]) {
            
            [IDInfoList sharedInstance].smResult = @"此人属于黑名单列表，禁止进入！";
            
            return;
        }
        
        [self showSVPSuccess:@"扫描身份证信息与绑定身份证信息一致"];
        [self performSelector:@selector(back) withObject:nil afterDelay:1];
        
    }else{
        
        [self addLoadingView];
        
        BaseStore *store = [[BaseStore alloc] init];
        NSString *id_card = [IDInfoList sharedInstance].idInfo.num;
        NSString *vr_id = [ScanList sharedInstance].scanModel.vr_id;
        NSString *visiter_id = [ScanList sharedInstance].scanModel.visitor_id;
        NSString *school_id = [UserDefaultsTool getSchoolId];
        NSString *security_personnel_id = [UserDefaultsTool getSecurityId];
        
        MJWeakSelf
        [store confirmIdCardWithIdCard:id_card andVrId:vr_id andVisiterId:visiter_id andSchoolId:school_id andSecuriyyId:security_personnel_id Success:^{
            
            [weakSelf showSVPSuccess:@"扫描身份证信息与绑定身份证信息一致"];
            
            [IDInfoList sharedInstance].smResult = @"扫描身份证信息与绑定身份证信息一致";
            
            [weakSelf performSelector:@selector(back) withObject:nil afterDelay:1];
            
            
        } Failure:^(NSError *error) {
            
            [weakSelf showSVPError:[HttpTool handleError:error]];
            
            [IDInfoList sharedInstance].smResult = [HttpTool handleError:error];
            
        }];
    }
    

}
- (void)back{
    
    [SVProgressHUD dismiss];
    
    if (self.type == 1) {
        
        UIViewController *VC = self.navigationController.viewControllers[3];
        [self.navigationController popToViewController:VC animated:YES];
    }else{
        
        UIViewController *VC = self.navigationController.viewControllers[2];
        [self.navigationController popToViewController:VC animated:YES];
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
