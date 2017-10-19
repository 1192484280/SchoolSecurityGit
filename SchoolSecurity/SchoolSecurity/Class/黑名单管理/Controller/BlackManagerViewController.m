//
//  BlackManagerViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BlackManagerViewController.h"
#import "SchoolBlackListViewController.h"
#import "PoliceBlackListViewController.h"

@interface BlackManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *listArr;

@end

@implementation BlackManagerViewController

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSArray arrayWithObjects:@"学校黑名单",@"公安黑名单", nil];
    }
    
    return _listArr;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iPhoneX_Top , ScreenWidth, ScreenHeight - (iPhoneX_Top) - (iPhoneX_Bottom)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 10;
        _tableView.sectionFooterHeight = 2;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView setContentInset:UIEdgeInsetsMake(-15, 0, 0, 0)];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"黑名单管理"];
    
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
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.listArr[indexPath.section];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        SchoolBlackListViewController *schoolVC = [[SchoolBlackListViewController alloc] init];
        [self.navigationController pushViewController:schoolVC animated:YES];
    }else{
        
        PoliceBlackListViewController *policeVC = [[PoliceBlackListViewController alloc] init];
        [self.navigationController pushViewController:policeVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
