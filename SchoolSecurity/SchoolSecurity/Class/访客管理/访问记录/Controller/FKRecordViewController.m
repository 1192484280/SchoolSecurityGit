//
//  FKRecordViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "FKRecordViewController.h"
#import "LFManagerCell.h"
#import "LFDetailViewController.h"
#import "LFDetailEditViewController.h"

@interface FKRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,LFManagerCellDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *listArr;

@property (strong, nonatomic) LFParametersModel *parameterMadel;

@end

@implementation FKRecordViewController

- (NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
}
- (LFParametersModel *)parameterMadel{
    
    if (!_parameterMadel) {
        
        _parameterMadel = [[LFParametersModel alloc] init];
        _parameterMadel.school_id = [UserDefaultsTool getSchoolId];
        _parameterMadel.page = @"1";
        _parameterMadel.visitor_id = self.visitor_id;
    }
    return _parameterMadel;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5, ScreenWidth, ScreenHeight - (iPhoneX_Top) - 0.5) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.sectionHeaderHeight = 9.5;
        _tableView.sectionFooterHeight = 0.5;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = [LFManagerCell getHeight];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        //创建下拉刷新控件
        MJWeakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.parameterMadel.page = @"1";
            [weakSelf refreshList];
        }];
        
        [_tableView.mj_header beginRefreshing];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"访问记录"];
    
    [self addShownWithY:iPhoneX_Top];
    
    [self.view addSubview:self.tableView];
    
    
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
            
            [self refreshList];
        }];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        
        LFDetailViewController *detailVC = [[LFDetailViewController alloc] init];
        
        detailVC.vr_id = model.vr_id;
        
        [detailVC returnMyBlock:^{
            
            [self refreshList];
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

- (void)refreshList
{
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    MJWeakSelf
    [store getLFManagerListWithParametersModel:self.parameterMadel Success:^(NSArray *arr, BOOL haveMore) {
        
        [weakSelf removeLoadingView];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if ([weakSelf.parameterMadel.page isEqualToString:@"1"]) {
            
            weakSelf.listArr = [NSMutableArray arrayWithArray:arr];
        }else{
            
            [weakSelf.listArr addObjectsFromArray:arr];
            
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
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
    
    
}

- (void)loadMoreData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        int a = [self.parameterMadel.page intValue];
        a++;
        self.parameterMadel.page = [NSString stringWithFormat:@"%d",a];
        [self refreshList];
        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
