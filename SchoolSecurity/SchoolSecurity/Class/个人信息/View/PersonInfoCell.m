//
//  PersonInfoCell.m
//  SecurityManager
//
//  Created by zhangming on 17/8/28.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "PersonInfoCell.h"
#import "PersonList.h"

@interface PersonInfoCell()

@end

@implementation PersonInfoCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identity = @"";
    NSInteger index = 0;
    switch (indexPath.section) {
        case 0:
            
            identity = @"CELL1";
            index = 0;
            break;
        
        case 1:
            
            identity = @"CELL2";
            index = 1;
            break;
            
        default:
            
            identity = @"CELL3";
            index = 2;
            break;
    }
    
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        
        CLASSNAME
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}

+ (instancetype)cellWidthIndexPath:(NSIndexPath *)indexPath{
    
    CLASSNAME
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil]objectAtIndex:indexPath.section];
}

+ (CGFloat)getHeightWidthIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self cellWidthIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)setTitle:(NSString *)title{
    
    self.titleLa.text = title;
    self.placeText.placeholder = [NSString stringWithFormat:@"   请输入%@",title];
     
    if ([title isEqualToString:@"姓名"]) {
        
        self.placeText.text = [PersonList sharedInstance].personModel.name;
        
        
    }else if ([title isEqualToString:@"身份证号"]){
        
        self.placeText.text = [PersonList sharedInstance].personModel.id_card;
    
        
    }else if([title isEqualToString:@"电话"]){
        
        self.placeText.text = [PersonList sharedInstance].personModel.mphone;
        
    }else{
        
        NSString *img = [NSString stringWithFormat:@"%@/%@",IP,[PersonList sharedInstance].personModel.headimg];
        
        [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"add_img"]];
        
    }
}


- (IBAction)onHeaderBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onHeaderBtn)]) {
        
        [self.delegate onHeaderBtn];
    }
}

- (IBAction)onSaveBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSaveBtn)]) {
        
        [self.delegate onSaveBtn];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
