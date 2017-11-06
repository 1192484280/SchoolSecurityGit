//
//  LookOtherCallerCell.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/11/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LookOtherCallerCell.h"

@implementation LookOtherCallerCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    LookOtherCallerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
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

- (void)setModel:(OtherVisiterModel *)model{
    
    self.La_name.text = model.name;
    self.La_idCard.text = model.id_card;
    
    if ([model.gender isEqualToString:@"1"]) {
        
        self.La_gender.text = @"男";
    }else{
        
        self.La_gender.text = @"女";
    }
    self.La_nation.text = model.nation;
    self.La_birthday.text = model.birthday;
    self.La_address.text = model.address;
    self.La_part.text = model.part;
    self.La_date.text = [NSString stringWithFormat:@"%@-%@",model.start_date,model.end_date];
    
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
