//
//  SettingViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/10/10.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (copy, nonatomic) NSArray *listArr;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SettingViewController

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSArray arrayWithObjects:@"注销登录", nil];
    }
    
    return _listArr;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) +0.5  , ScreenWidth, ScreenHeight - (iPhoneX_Top) - (iPhoneX_Bottom) - 0.5) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = groupSectionHeaderHeight;
        _tableView.sectionFooterHeight = groupSectionFooterHeight;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, topSpacing)];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"设置"];
    
    [self addShownWithY:iPhoneX_Top];
    
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.listArr[indexPath.section];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor redColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            
            [self loginOut];
            break;
            
        default:
            break;
    }
}

- (void)loginOut{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认登出" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [SVProgressHUD show];
        [UserDefaultsTool deleteObjWithKey:@"account"];
        [UserDefaultsTool deleteObjWithKey:@"passWord"];
        [UserDefaultsTool deleteObjWithKey:@"school_id"];
        [UserDefaultsTool deleteObjWithKey:@"security_personnel_id"];
        [UserDefaultsTool deleteObjWithKey:@"userName"];
        [UserDefaultsTool deleteObjWithKey:@"userTel"];
        [UserDefaultsTool deleteObjWithKey:@"userHeadimg"];
        
        [self performSelector:@selector(onLoginOut) withObject:nil afterDelay:0.5];
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}

- (void)onLoginOut{
    
    [self showSVPSuccess:@"成功登出"];
    
    if (self.loginOutBlock != nil) {
        
        self.loginOutBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)returnBlock:(loginOutBlock)block{
    
    self.loginOutBlock = block;
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
