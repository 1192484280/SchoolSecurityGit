//
//  LFManagerSearchResultViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/9/11.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFManagerSearchResultViewController.h"
#import "LFManagerCell.h"
#import "LFDetailViewController.h"

@interface LFManagerSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,LFManagerCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *listArr;



@end

@implementation LFManagerSearchResultViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iPhoneX_Top , ScreenWidth, ScreenHeight - (iPhoneX_Top)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = groupSectionHeaderHeight;
        _tableView.sectionFooterHeight = groupSectionFooterHeight;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = [LFManagerCell getHeight];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, topSpacing)];
        
        //创建下拉刷新控件
        MJWeakSelf
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weakSelf.parameterModel.page = @"1";
            [weakSelf refreshList];
        }];
        
        [_tableView.mj_header beginRefreshing];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackBtnNavBarWithTitle:@"搜索结果"];
    [self addShownWithY:iPhoneX_Top];
    
    [self.view addSubview:self.tableView];
}

- (void)loadMoreData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        int a = [self.parameterModel.page intValue];
        a++;
        self.parameterModel.page = [NSString stringWithFormat:@"%d",a];
        [self refreshList];
        
    });
    
}

- (void)refreshList
{
    MJWeakSelf
    
    BaseStore *store = [[BaseStore alloc] init];
    
    
    [store getLFManagerListWithParametersModel:self.parameterModel Success:^(NSArray *arr, BOOL haveMore) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if ([self.parameterModel.page isEqualToString:@"1"]) {
            
            self.listArr = [NSMutableArray arrayWithArray:arr];
        }else{
            
            [self.listArr addObjectsFromArray:arr];
        }
        
        if (haveMore == NO) {
            
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            
        }else{
            
            self.tableView.mj_footer.state = MJRefreshStateIdle;
        }
        [weakSelf.tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
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
    
    LFDetailViewController *detailVC = [[LFDetailViewController alloc] init];
    LFModel *model = self.listArr[indexPath.section];
    detailVC.vr_id = model.vr_id;
    [detailVC returnMyBlock:^{
       
        [self refreshList];
    }];
    [self.navigationController pushViewController:detailVC animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
