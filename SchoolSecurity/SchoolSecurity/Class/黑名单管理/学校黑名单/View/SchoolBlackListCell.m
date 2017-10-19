//
//  SchoolBlackListCell.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SchoolBlackListCell.h"

@implementation SchoolBlackListCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    SchoolBlackListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
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


- (void)setModel:(SchoolBlackListModel *)model{
    
    self.nameLa.text = model.name;
    self.idCardLa.text = model.id_card;
}
- (IBAction)onEditBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onEditBtnWithIndexPath:)]) {
        
        [self.delegate onEditBtnWithIndexPath:self.indexPath];
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
