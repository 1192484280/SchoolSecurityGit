//
//  FKManagerCell.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "FKManagerCell.h"

@implementation FKManagerCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    FKManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (!cell) {
        
        CLASSNAME
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    
    return cell;
}


+ (CGFloat)getHeight{
    
    UITableViewCell *cell = [self cell];
    
    return cell.frame.size.height;
}

+ (instancetype)cell{
    
    CLASSNAME
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

- (void)setModel:(FKModel *)model{
    
    self.nameLa.text = model.id_name;
    self.telLa.text = model.visitor_tel;
    self.numLa.text = model.visits_number;
    self.dateLa.text = model.visitor_time;
}

- (IBAction)onLookBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onLookDetailBtnWithIndex:)]) {
        
        
        [self.delegate onLookDetailBtnWithIndex:self.rowOfCell];
    }
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
