//
//  LFSubViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFSubViewController.h"
#import "LFManagerCell.h"
#import "LFDetailViewController.h"
#import "LFDetailEditViewController.h"
#import "LFManager+CoreDataProperties.h"

@interface LFSubViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,LFManagerCellDelegate>

@property (strong, nonatomic) LFParametersModel *Md;

@property (strong, nonatomic) NSMutableArray *listArr;

@end

@implementation LFSubViewController



- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
}
- (LFParametersModel *)Md{
    
    if (!_Md) {
        
        _Md = [[LFParametersModel alloc] init];
        _Md.school_id = [UserDefaultsTool getSchoolId];
        _Md.status = @"0";
        _Md.page = @"1";
    }
    return _Md;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - (iPhoneX_Top) - typeViewHeight - 1.5) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableView数据为空时显示内容代理
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    tableView.estimatedRowHeight = [LFManagerCell getHeight];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.sectionHeaderHeight = groupSectionHeaderHeight;
    tableView.sectionFooterHeight = groupSectionFooterHeight;
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.tableView = tableView;
    
    //创建下拉刷新控件
    MJWeakSelf
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.Md.page = @"1";
        [weakSelf refreshListModel:self.Md Complete:^{
            
        }];
    }];
    
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        int a = [self.Md.page intValue];
        a++;
        self.Md.page = [NSString stringWithFormat:@"%d",a];
        [self refreshListModel:self.Md Complete:^{
            
        }];
        
    });
    
}

- (void)refreshListModel:(LFParametersModel*)model Complete:(void(^)())complete
{

    self.Md = model;
    
    MJWeakSelf
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"])
    {
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[LFManager class] where:[NSString stringWithFormat:@"status = '%@'",model.status] Alldata_arr:^(NSArray *coredataModelArr) {
           
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            weakSelf.listArr = [NSMutableArray array];
            if (coredataModelArr.count > 0) {
                
                
                weakSelf.listArr = [NSMutableArray arrayWithArray:coredataModelArr];
                
            }
            
            [weakSelf.tableView reloadData];
            
            if (complete) {
                complete();
            }
            
        } Error:^(NSError *error) {
            
            if (complete) {
                complete();
            }
        }];
        return;
    }
    
    BaseStore *store = [[BaseStore alloc] init];
    [store getLFManagerListWithParametersModel:self.Md Success:^(NSArray *arr,BOOL haveMore) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if ([weakSelf.Md.page isEqualToString:@"1"]) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:arr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:arr];
        }
        
        if (haveMore == NO) {
            
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            
        }else{
            
            weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
        }
        
        [weakSelf.tableView reloadData];
        
        if (complete) {
            complete();
        }
        
    } Failure:^(NSError *error) {
    
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (complete) {
            complete();
        }
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LFManagerCell *cell = [LFManagerCell tempWithTableView:tableView];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = self.listArr[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 查看详情
- (void)onDetailBtn:(NSIndexPath *)indexPath{
    
    LFModel *model = self.listArr[indexPath.section];
    
    if ([model.status isEqualToString:@"0"] || [model.status isEqualToString:@"1"]) {
        
        LFDetailEditViewController *detailVC = [[LFDetailEditViewController alloc] init];
        
        detailVC.vr_id = model.vr_id;
        [detailVC returnMyBlock:^{
           
            [self refreshListModel:self.Md Complete:nil];
        }];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        
        LFDetailViewController *detailVC = [[LFDetailViewController alloc] init];
        
        detailVC.vr_id = model.vr_id;
        
        [detailVC returnMyBlock:^{
            
            [self refreshListModel:self.Md Complete:nil];
        }];
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark -
#pragma mark - DZNEmptyDataSetDelegate(没有数据时显示)
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有加载到数据";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"moren_noorder"];
}


//背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor colorWithHexString:@"#efeff4"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
