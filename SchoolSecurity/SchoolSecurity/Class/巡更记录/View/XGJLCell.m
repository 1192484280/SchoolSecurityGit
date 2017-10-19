//
//  XGJLCell.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGJLCell.h"

@implementation XGJLCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    XGJLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
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

#pragma mark - 点击查看详情
- (IBAction)LookDetail:(UIButton *)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(onDetailBtn:)]){
        
        [self.delegate onDetailBtn:self.indexPath];
    }
}

- (void)setModel:(XGJLModel *)model{
    
    self.timeLa.text = model.patrol_time;
    self.pointLa.text = [NSString stringWithFormat:@"%@个",model.psr_number];
    self.rangeLa.text = [NSString stringWithFormat:@"%@公里",model.distance];
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
