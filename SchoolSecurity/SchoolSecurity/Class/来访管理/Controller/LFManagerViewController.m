//
//  LFManagerViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFManagerViewController.h"
#import "TypeScrollView.h"
#import "LFSubViewController.h"
#import "LFChildScrollView.h"
#import "LFSearchViewController.h"

@interface LFManagerViewController ()<TypeScrollViewDelegate,LFChildScrollViewDelegate>
{
    
    CGFloat typeViewY;
}
@property (weak, nonatomic) TypeScrollView *typeView;

@property (weak, nonatomic) LFChildScrollView *scrollView;

@property (copy, nonatomic) NSArray *titles;

@end


@implementation LFManagerViewController

- (NSArray *)titles{
    
    if (!_titles) {
        
        _titles = @[@"未回复",@"受访人同意",@"受访人拒绝",@"已进入",@"已离开",@"拒绝进入"];
    }
    return _titles;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    typeViewY = (iPhoneX_Top) + 0.5 ;
    
    [self setNavBar];
    
    [self addSubViewController];
    
    [self setUI];
    
}

- (void)setNavBar{
    
    [self setupBackBtnNavBarWithTitle:@"来访管理"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_supSearch" selectedImageName:@"icon_supSearch" target:self action:@selector(onSearchBtn)];
    
    [self addShownWithY:iPhoneX_Top];
    
}

- (void)addSubViewController
{
    LFSubViewController *subVC1 = [[LFSubViewController alloc] init];
    [self addChildViewController:subVC1];
    
    LFSubViewController *subVC2 = [[LFSubViewController alloc] init];
    [self addChildViewController:subVC2];
    
}

- (void)setUI{
    
    self.view.backgroundColor = VIEWCOLOR;
    TypeScrollView *typeView = [[TypeScrollView alloc] initWithFrame:CGRectMake(0, typeViewY, ScreenWidth, typeViewHeight) Titles:self.titles];
    typeView.myDelegate = self;
    typeView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:typeView];
    self.typeView = typeView;
    
    LFChildScrollView *scrollView = [[LFChildScrollView alloc] initWithFrame:CGRectMake(0, typeViewY + typeViewHeight + 1, ScreenWidth, ScreenHeight - (typeViewY + typeViewHeight + 1)) ChildViewControllers:self.childViewControllers MaxCount:self.titles.count];
    scrollView.myDelegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

#pragma mark - TypeScrollViewDelegate
- (void)didTypeWithIndex:(NSInteger)index
{
    [self.scrollView scrollViewWithIndex:index];
}

- (void)scrollViewEndSlideWithIndex:(NSInteger)index
{
    [self.typeView selectedButtonForIndex:index];
}

#pragma mark - 高级搜索
- (void)onSearchBtn{
    
    LFSearchViewController *VC = [[LFSearchViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
