//
//  XGJLViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGJLViewController.h"
#import "XGJLCell.h"
#import "XGDDetailViewController.h"
#import "XGStartViewController.h"
#import "XGJL+CoreDataProperties.h"

@interface XGJLViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,XGJLCellDelegate>
{
    NSString *page;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *listArr;
@end

@implementation XGJLViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5 , ScreenWidth, ScreenHeight - (iPhoneX_Top)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = groupSectionFooterHeight;
        _tableView.sectionFooterHeight = groupSectionHeaderHeight;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, topSpacing)];
        //创建下拉刷新控件
        MJWeakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            page = @"1";
            [weakSelf refreshList];
        }];
        
        [_tableView.mj_header beginRefreshing];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self addShownWithY:iPhoneX_Top];
    
    [self.view addSubview:self.tableView];
    
}

- (void)setNavBar{
    
    [self setupBackBtnNavBarWithTitle:@"巡更记录"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_navStart" selectedImageName:@"icon_navStart" target:self action:@selector(onStart)];
}

#pragma mark - 开始巡更
- (void)onStart{
    
    XGStartViewController *VC = [[XGStartViewController alloc] init];
    
    [VC returnXGEndBlock:^{
    
        [self refreshList];
    }];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [XGJLCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XGJLCell *cell = [XGJLCell tempWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.model = self.listArr[indexPath.section];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)onDetailBtn:(NSIndexPath *)indexpath{
    
    XGJLModel *model = self.listArr[indexpath.section];
    
    XGDDetailViewController *VC = [[XGDDetailViewController alloc] init];
    
    VC.p_id = model.p_id;
    
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)loadMoreData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        int a = [page intValue];
        a++;
        page = [NSString stringWithFormat:@"%d",a];
        [self refreshList];
        
    });
    
}
- (void)refreshList{
    
    MJWeakSelf
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[XGJL class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            if (coredataModelArr.count > 0) {
                
                weakSelf.listArr = [NSMutableArray arrayWithArray:coredataModelArr];
                [weakSelf.tableView reloadData];
            }else{
                
                [weakSelf showSVPError:@"网络加载失败"];
            }
        } Error:^(NSError *error) {
            
        }];
        return;
    }
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *schoolId = [UserDefaultsTool getSchoolId];
    NSString *securityId = [UserDefaultsTool getSecurityId];
    
    
    [store getXGLBWithSchoolId:schoolId andSecurityId:securityId andPage:page Success:^(NSArray *listArr, BOOL haveMore) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if ([page isEqualToString:@"1"]) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:listArr];
        }else{
            weakSelf.listArr = [NSMutableArray arrayWithArray:listArr];
            //[weakSelf.listArr addObjectsFromArray:listArr];
            
            if (haveMore == NO) {
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                
            }else{
                
                weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
            }
            
        }
        
        [weakSelf.tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:[HttpTool handleError:error]];
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
