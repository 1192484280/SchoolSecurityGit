//
//  SchoolBlackListViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SchoolBlackListViewController.h"
#import "SchoolBlackListCell.h"
#import "AddBlackListViewController.h"
#import "EditBlackListViewController.h"
#import "AllSchoolBlack+CoreDataProperties.h"

@interface SchoolBlackListViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,SchoolBlackListCellDelegate>
{
    NSString *page;
}
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *listArr;

@end

@implementation SchoolBlackListViewController

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top)+0.5  , ScreenWidth, ScreenHeight - (iPhoneX_Top) - 0.5) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.sectionHeaderHeight = groupSectionHeaderHeight;
        _tableView.sectionFooterHeight = groupSectionFooterHeight;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, topSpacing)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        
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
    
    [self setupBackBtnNavBarWithTitle:@"学校黑名单"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_addNew" selectedImageName:@"icon_addNew" target:self action:@selector(onAddBtn)];
    
}

- (void)onAddBtn{
    
    AddBlackListViewController *addVC = [[AddBlackListViewController alloc] init];
    
    addVC.blackListType = SchoolBlackList;
    
    [addVC returnMyBlock:^{
       
        [self refreshList];
    }];
    
    [self.navigationController pushViewController:addVC animated:YES];
    
}

- (void)refreshList{
    
    MJWeakSelf
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[AllSchoolBlack class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
            
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            if (coredataModelArr.count > 0) {
                
                weakSelf.listArr = [NSMutableArray arrayWithArray:coredataModelArr];
                [weakSelf.tableView reloadData];
            }
        } Error:^(NSError *error) {
            
        }];
        
        return;
    }
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *schoolId = [UserDefaultsTool getSchoolId];
    
    [store getSchoolBlackListWithSchoolID:schoolId andPage:page Succes:^(NSArray *arr, BOOL haveMore) {
        
        [weakSelf removeLoadingView];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if ([page isEqualToString:@"1"]) {
            
            self.listArr = [NSMutableArray arrayWithArray:arr];
        }else{
            
            [self.listArr addObjectsFromArray:arr];
            
            if (haveMore == NO) {
                
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                
            }else{
                
                self.tableView.mj_footer.state = MJRefreshStateIdle;
            }
            
        }
        
        [weakSelf.tableView reloadData];
        
    } Failure:^(NSError *error) {
        
        [weakSelf removeLoadingView];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
    
    
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [SchoolBlackListCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SchoolBlackListCell *cell = [SchoolBlackListCell tempWithTableView:tableView];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = self.listArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)onEditBtnWithIndexPath:(NSIndexPath *)indexPath{
    
    SchoolBlackListModel *model = self.listArr[indexPath.section];
    
    EditBlackListViewController *editVC = [[EditBlackListViewController alloc] init];
    editVC.Id = model.bl_id;
    editVC.blackListType = SchoolBlackList;
    editVC.schoolId = model.school_id;
    editVC.schoolModel = model;
    
    [editVC returnMyBlock:^{
        
        [self refreshList];
    }];
    [self.navigationController pushViewController:editVC animated:YES];
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
