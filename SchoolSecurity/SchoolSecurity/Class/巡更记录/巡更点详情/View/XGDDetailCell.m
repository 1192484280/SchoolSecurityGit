//
//  XGDDetailCell.m
//  SecurityManager
//
//  Created by zhangming on 17/8/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGDDetailCell.h"

@implementation XGDDetailCell


+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    
    XGDDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1"];
    
    if (!cell) {
        
        CLASSNAME
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
    }
    
    return cell;
}


+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self cellWithIndexPath:indexPath];
    
    return cell.frame.size.height;
}

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath{
    
    CLASSNAME
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] objectAtIndex:0];
}

- (void)setModel:(XGPointModel *)model{
    
    self.titleLa.text = model.name;
    self.timeLa.text = model.psr_add_time;
    self.noteLa.text = model.note;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
