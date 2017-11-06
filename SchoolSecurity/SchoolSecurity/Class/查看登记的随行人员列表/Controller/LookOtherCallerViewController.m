//
//  LookOtherCallerViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/11/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LookOtherCallerViewController.h"
#import "LookOtherCallerCell.h"
#import "OtherVisiterList.h"

@interface LookOtherCallerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation LookOtherCallerViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5 , ScreenWidth, ScreenHeight - (iPhoneX_Top + 0.5)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionHeaderHeight = groupSectionHeaderHeight;
        _tableView.sectionFooterHeight = groupSectionFooterHeight;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, topSpacing)];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"随行人员信息"];
    
    [self addShownWithY:iPhoneX_Top];
    
    [self.view addSubview:self.tableView];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [OtherVisiterList sharedInstance].otherVisiterListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [LookOtherCallerCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LookOtherCallerCell *cell = [LookOtherCallerCell tempWithTableView:tableView];
    cell.model = [OtherVisiterList sharedInstance].otherVisiterListArr[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
