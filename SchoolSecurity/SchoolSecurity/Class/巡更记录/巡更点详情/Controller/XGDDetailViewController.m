//
//  XGDDetailViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/28.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGDDetailViewController.h"
#import "XGDDetailHeaderView.h"
#import "XGDDetailCell.h"
#import "XGPointModel.h"

@interface XGDDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) XGDDetailHeaderView *headerView;

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *listArr;

@end

@implementation XGDDetailViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5, ScreenWidth, ScreenHeight - (iPhoneX_Top) - 0.5) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(XGHeaderHeight, 0, 0, 0);
        [_tableView setContentOffset:CGPointMake(0, -XGHeaderHeight)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
       _tableView.separatorColor = [UIColor blackColor]; _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavbar];
    
    [self setupUI];
    
    [self refreshList];
    
}

- (void)setNavbar{
    
    self.title = @"巡更详情";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" selectedImageName:@"icon_back_normal" target:self action:@selector(back)];
}


- (void)setupUI{
    
    XGDDetailHeaderView *headerView = [[XGDDetailHeaderView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5, ScreenWidth, XGHeaderHeight)];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [XGDDetailCell getHeightWithIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XGDDetailCell *cell = [XGDDetailCell tempWithTableView:tableView andIndexPath:indexPath];
    cell.model = self.listArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

#pragma mark - 分割线顶到边
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath: (NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= -XGHeaderHeight) {
        
        [self.view bringSubviewToFront:self.headerView];
    }else{
        
        [self.view bringSubviewToFront:self.tableView];
    }
}

- (void)refreshList{
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    MJWeakSelf
    [store getXGDetailWithP_id:self.p_id Success:^(XGDetailModel *model) {
        
        [weakSelf removeLoadingView];
        
        weakSelf.headerView.model = model;
        
        weakSelf.listArr = [XGPointModel mj_objectArrayWithKeyValuesArray:model.psr_info];
        [weakSelf.tableView reloadDataAnimateWithWave:RightToLeftWaveAnimation];
        
        
    } Failure:^(NSError *error) {
        
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
