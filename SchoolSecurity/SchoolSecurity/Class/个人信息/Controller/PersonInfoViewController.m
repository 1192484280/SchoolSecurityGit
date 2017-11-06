//
//  PersonInfoViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PersonInfoCell.h"
#import "PersonList.h"

@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PersonInfoCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerControllerSourceType sourceType;
}
@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *titlesArr;

@property (copy, nonatomic) NSArray *placeHoderArr;

@property (strong, nonatomic) UIImage *theNewImg;

@end

@implementation PersonInfoViewController


- (NSArray *)titlesArr{
    
    if (!_titlesArr) {
        
        _titlesArr = @[@[@""],@[@"姓名",@"身份证号",@"电话"],@[@""]];
    }
    
    return _titlesArr;
}



- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (iPhoneX_Top) + 0.5, ScreenWidth, ScreenHeight - (iPhoneX_Top) - 0.5) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = groupSectionHeaderHeight;
        _tableView.sectionFooterHeight = groupSectionFooterHeight;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, topSpacing)];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _theNewImg = nil;
    
    [self setupBackBtnNavBarWithTitle:@"个人信息"];
    
    [self addShownWithY:iPhoneX_Top];
    
    [self.view addSubview:self.tableView];
    
    [self refreshList];
    
}

- (void)refreshList{
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [PersonList sharedInstance].personModel.name = [UserDefaultsTool getObjWithKey:@"userName"];
        [PersonList sharedInstance].personModel.id_card = [UserDefaultsTool getObjWithKey:@"id_card"];
        [PersonList sharedInstance].personModel.mphone = [UserDefaultsTool getObjWithKey:@"mphone"];
        [PersonList sharedInstance].personModel.headimg = [UserDefaultsTool getObjWithKey:@"userHeadimg"];
        
        return;
    }
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *school_id = [UserDefaultsTool getSchoolId];
    NSString *security_personnel_id = [UserDefaultsTool getSecurityId];
    
    MJWeakSelf
    
    [store getPersonInfoWithSchoolId:school_id andSecurityId:security_personnel_id Success:^{
        
        [weakSelf removeLoadingView];
        [weakSelf.tableView reloadData];
        
    }Failure:^(NSError *error) {
        
        [weakSelf removeLoadingView];
        [SVProgressHUD showErrorWithStatus:[HttpTool handleError:error]];
    }];
    
}


#pragma mark -
#pragma mark - 实现TableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.titlesArr[section];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titlesArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [PersonInfoCell getHeightWidthIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonInfoCell *cell = [PersonInfoCell tempWithTableView:tableView andIndexPath:indexPath];
    cell.title = self.titlesArr[indexPath.section][indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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


#pragma mark - 点击头像
- (void)onHeaderBtn{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        picker.sourceType=sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            
            picker.delegate = self;
            
            picker.sourceType=sourceType;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            
            picker.delegate = self;
            
            picker.sourceType=sourceType;
            
            [self presentViewController:picker animated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
}

#pragma mark - 相册选择完成
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.theNewImg = image;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    PersonInfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    [cell.headerBtn setImage:image forState:UIControlStateNormal];
    
}

#pragma mark - 保存
- (void)onSaveBtn{
    
    [PersonList sharedInstance].parameterModel = [[PersonParameterModel alloc] init];
    [PersonList sharedInstance].parameterModel.security_personnel_id = [UserDefaultsTool getSecurityId];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    PersonInfoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (!(self.theNewImg == nil)) {
        
        UIImage *im1 = [self imageWithImageSimple:self.theNewImg scaledToSize:CGSizeMake(200, 200)];
        [PersonList sharedInstance].parameterModel.headimg = [ImgToBatManager image2DataURL:im1];
    }
    
    
    indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (!(cell.placeText.text.length > 0)) {
        
        [self showMBPError:@"请输入姓名"];
        return;
    }
    [PersonList sharedInstance].parameterModel.name = cell.placeText.text;
    
    indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    
    cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (!(cell.placeText.text.length > 0)) {
        
        [self showMBPError:@"请输入身份证号"];
        return;
    }
    
    [PersonList sharedInstance].parameterModel.id_card = cell.placeText.text;
    
    indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    
    cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (!(cell.placeText.text.length > 0)) {
        
        [self showMBPError:@"请输入电话"];
        return;
    }
    
    [PersonList sharedInstance].parameterModel.mphone = cell.placeText.text;
    

    [SVProgressHUD show];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    MJWeakSelf
    [store changePersonInfoWithParameter:[PersonList sharedInstance].parameterModel Success:^{
        
        [weakSelf removeLoadingView];
        
        [weakSelf showSVPSuccess:@"保存成功"];
        
        [self upPersonInfo];
        
        _theNewImg = nil;
        
        [weakSelf performSelector:@selector(goBack) withObject:nil afterDelay:0.5];
    
    } Failure:^(NSError *error) {
       
        [weakSelf removeLoadingView];
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
}

- (void)upPersonInfo{
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *school_id = [UserDefaultsTool getSchoolId];
    NSString *security_personnel_id = [UserDefaultsTool getSecurityId];
    
    MJWeakSelf
    [store getPersonInfoWithSchoolId:school_id andSecurityId:security_personnel_id Success:^{
        
        [UserDefaultsTool setObj:[PersonList sharedInstance].personModel.name andKey:@"userName"];
        [UserDefaultsTool setObj:[PersonList sharedInstance].personModel.mphone andKey:@"mphone"];
        [UserDefaultsTool setObj:[PersonList sharedInstance].personModel.headimg andKey:@"userHeadimg"];
        
        if (weakSelf.changePersonblock != nil) {
            
            weakSelf.changePersonblock();
        }
        
        
    } Failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (void)goBack{
    
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)returnMyBlock:(changePersonInfoBlock)block{
    
    self.changePersonblock = block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
