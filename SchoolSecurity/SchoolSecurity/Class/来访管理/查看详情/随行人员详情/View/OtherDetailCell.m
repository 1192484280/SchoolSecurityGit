//
//  OtherDetailCell.m
//  SecurityManager
//
//  Created by zhangming on 17/9/11.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "OtherDetailCell.h"

@implementation OtherDetailCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    OtherDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (!cell) {
        
        CLASSNAME
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    
    return cell;
}

+ (instancetype)cell{
    
    CLASSNAME
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [self cell];
    return cell.frame.size.height;
}

- (void)setModel:(OtherDetailModel *)model{
    
    self.La_name.text = model.id_name;
    self.La_idCard.text = model.id_card;
    
    if ([model.id_sex isEqualToString:@"1"]) {
        
        self.La_gender.text = @"男";
    }else{
        
        self.La_gender.text = @"女";
    }
    self.La_nation.text = model.id_nation;
    self.La_birthday.text = model.id_birthday;
    self.La_address.text = model.id_address;
    self.La_part.text = model.id_release_organ;
    self.La_date.text = model.id_validity_date;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
