//
//  FKDetailViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "FKDetailViewController.h"
#import "FKRecordViewController.h"

@interface FKDetailViewController ()
{
    
    IBOutlet NSLayoutConstraint *viewY;
}
@end

@implementation FKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addShownWithY:iPhoneX_Top];
    viewY.constant = (iPhoneX_Top) + topSpacing;
    
    [self setupBackBtnNavBarWithTitle:@"访客详细"];
    
    [self addLoadingView];
    [self refreshList];
}


- (void)refreshList{
    
    
    BaseStore *store = [[BaseStore alloc] init];
    
    MJWeakSelf
    [store getDetailInfoWithVisitor_id:self.visitor_id Success:^(FKDetailMode *model) {
        
        [weakSelf removeLoadingView];
        
        [weakSelf setModelWithModel:model];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
}

- (void)setModelWithModel:(FKDetailMode *)model{
    
    self.nameLa.text = model.name;
    self.idCardLa.text = model.id_card;
    
    if ([model.sex isEqualToString:@"1"]) {
        
        self.genderLa.text = @"男";
    }else{
        
        self.genderLa.text = @"女";
    }
    
    self.dateLa.text = model.birthday;
}
- (IBAction)onLookFKDetailBtn:(UIButton *)sender {
    
    FKRecordViewController *VC = [[FKRecordViewController alloc] init];
    VC.visitor_id = self.visitor_id;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
