//
//  LFChildScrollView.m
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFChildScrollView.h"
#import "LFSubViewController.h"
#import "LoadingView.h"

@interface LFChildScrollView ()<UIScrollViewDelegate>

@property (copy, nonatomic) NSArray *
children;

@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger maxCount;
@property (weak, nonatomic) LFSubViewController *vc1;
@property (weak, nonatomic) LFSubViewController *vc2;
@property (assign, nonatomic) NSInteger currentVcIndex;

@end

@implementation LFChildScrollView

- (instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)children MaxCount:(NSInteger)maxCount{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(self.width * 3, self.height);
        self.delegate = self;
        self.maxCount = maxCount;
        self.children = children;
        [self setup];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTypeNotification:) name:@"ApproveNotification" object:nil];
    }
    
    return self;
}

- (void)setup{
    
    LFSubViewController *vc1 = self.children[0];
    vc1.view.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:vc1.view];
    
    self.vc1 = vc1;
    
    LFParametersModel *model = [[LFParametersModel alloc] init];
    
    model.school_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"school_id"];
    model.status = @"0";
    model.page = @"1";
    
    LFSubViewController *vc2 = self.children[1];
    vc2.view.frame = CGRectMake(self.width, 0, self.width, self.height);
    [self addSubview:vc2.view];
    self.vc2 = vc2;
    
    [SVProgressHUD show];
    
    
    self.userInteractionEnabled = NO;
    
    MJWeakSelf
    [self.vc1 refreshListModel:model Complete:^{
        
        weakSelf.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
    }];
    
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.currentVcIndex == 1) {
        
        if (scrollView.contentOffset.x > self.width) {
            
            self.vc1.view.frame = CGRectMake(self.width*2, 0, self.width, self.height);
        }else if (scrollView.contentOffset.x < self.width){
            
            self.vc1.view.frame = CGRectMake(0, 0, self.width, self.height);
        }
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.userInteractionEnabled = YES;
    });
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.width;
    
    if (index == self.currentVcIndex) {
        
        return;
    }
    
    if (index == 0) {
        
        if (self.currentIndex > 0) {
            
            self.currentIndex -= 1 ;
        }
    }else if (index == 1){
        
        if (self.currentIndex == 0) {
            
            self.currentIndex += 1;
        }else if (self.currentIndex == self.maxCount - 1){
            
            self.currentIndex -= 1;
        }
    }else{
        
        if (self.currentIndex < self.maxCount - 1) {
            
            self.currentIndex += 1;
        }
    }
    
    if ([self.myDelegate respondsToSelector:@selector(scrollViewEndSlideWithIndex:)]) {
        
        [self.myDelegate scrollViewEndSlideWithIndex:self.currentIndex];
    }
}


- (void)scrollViewWithIndex:(NSInteger)index{
    
    
    if (index == 0) {
        
        self.vc1.view.frame = CGRectMake(0, 0, self.width, self.hash);
        [self loadData:index WithOffsetX:0 viewController:self.vc1];
        self.currentVcIndex = 0;
        
    }else if (index != self.maxCount - 1){
        
        [self loadData:index WithOffsetX:self.width viewController:self.vc2];
        self.currentVcIndex = 1;
        
    }else{
        
        self.vc1.view.frame = CGRectMake(self.width * 2, 0, self.width, self.height);
        [self loadData:index WithOffsetX:self.width * 2 viewController:self.vc1];
        self.currentVcIndex = 2;
    }
    self.currentIndex = index;
}


- (void)loadData:(NSInteger)index WithOffsetX:(CGFloat)offsetX viewController:(LFSubViewController *)vc
{
    
    
    
    [SVProgressHUD show];
    
    LFParametersModel *md = [[LFParametersModel alloc] init];
    md.school_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"school_id"];
    md.status = [NSString stringWithFormat:@"%ld",(long)index];
    md.page = @"1";
    MJWeakSelf
    [vc refreshListModel:md Complete:^{
        
        [SVProgressHUD dismiss];
        [weakSelf setContentOffset:CGPointMake(offsetX, 0)];
    }];
    
    [self.vc1.tableView setContentOffset:CGPointMake(0, 0)];
}

- (void)selectTypeNotification:(NSNotification *)notification
{
    [self scrollViewWithIndex:self.currentIndex];
}

@end
