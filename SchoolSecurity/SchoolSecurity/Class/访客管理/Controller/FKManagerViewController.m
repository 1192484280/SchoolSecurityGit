//
//  FKManagerViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "FKManagerViewController.h"
#import "FKManagerCell.h"
#import "FKParameterModel.h"
#import "FKManagerSearchViewController.h"
#import "FKDetailViewController.h"
#import "FKManager+CoreDataProperties.h"

@interface FKManagerViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,FKManagerCellDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *ListArr;

@property (strong, nonatomic) FKParameterModel *parameterModel;

@end

@implementation FKManagerViewController

- (FKParameterModel *)parameterModel{
    
    if (!_parameterModel) {
        
        _parameterModel = [[FKParameterModel alloc] init];
        _parameterModel.school_id = [UserDefaultsTool getSchoolId];
        _parameterModel.page = @"1";
    }
    return _parameterModel;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5  , ScreenWidth, ScreenHeight - (iPhoneX_Top) - 0.5) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.sectionHeaderHeight = groupSectionHeaderHeight;
        _tableView.sectionFooterHeight = groupSectionFooterHeight;
        _tableView.backgroundColor = [UIColor clearColor];
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
    
    [self setupNavBar];
    
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
- (void)refreshList{
    
    MJWeakSelf
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[FKManager class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            
            weakSelf.ListArr = [NSMutableArray arrayWithArray:coredataModelArr];
            [weakSelf.tableView reloadData];
        } Error:^(NSError *error) {
            
        }];
        return;
    }
   
    BaseStore *store = [[BaseStore alloc] init];
    
    [store getFKManagerListArrWithParameter:self.parameterModel Success:^(NSArray *arr, BOOL haveMore) {
        

        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if ([weakSelf.parameterModel.page isEqualToString:@"1"]) {
            
            weakSelf.ListArr = [NSMutableArray arrayWithArray:arr];
        }else{
            
            [weakSelf.ListArr addObjectsFromArray:arr];
            
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

- (void)setupNavBar{
    
    [self setupBackBtnNavBarWithTitle:@"访客管理"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_supSearch" selectedImageName:@"icon_supSearch" target:self action:@selector(onSearchBtn)];
    
}

#pragma mark -
#pragma mark - 实现TableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.ListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [FKManagerCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FKManagerCell *cell = [FKManagerCell tempWithTableView:tableView];
    cell.model = self.ListArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rowOfCell = indexPath.section;
    cell.delegate = self;
    
    return cell;
}


#pragma mark - 点击搜索
- (void)onSearchBtn{
    
    FKManagerSearchViewController *searchVC = [[FKManagerSearchViewController alloc] init];
    
    MJWeakSelf
    [searchVC returnText:^(FKParameterModel *model) {
        
        weakSelf.parameterModel = model;
        [self refreshList];
    }];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - 点击cell查看详情
- (void)onLookDetailBtnWithIndex:(NSInteger)row{
    
    FKModel *model = self.ListArr[row];
    
    FKDetailViewController *VC = [[FKDetailViewController alloc] init];
    
    VC.visitor_id = model.visitor_id;
    
    [self.navigationController pushViewController:VC animated:YES];
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
