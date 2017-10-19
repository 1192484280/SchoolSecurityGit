//
//  LFManagerCell.m
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LFManagerCell.h"

@implementation LFManagerCell

+ (instancetype)tempWithTableView:(UITableView *)tableView{
    
    LFManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
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


- (void)setModel:(LFModel *)model{
    
    self.visiterLa.text = model.visitor_name;
    self.callerLa.text = model.caller_name;
    self.timeLa.text = model.format_visitor_time;
    if (model.note.length>0) {
        self.reasonLa.text = model.note;
    }else{
        
        self.reasonLa.text = @"未备注";
    }
    if ([model.status isEqualToString:@"0"]) {
        
        self.statusLa.text = @"未回复";
        
    }else if ([model.status isEqualToString:@"1"]){
        
        self.statusLa.text = @"等待进入";
    }else if ([model.status isEqualToString:@"2"]){
        
        self.statusLa.text = @"受访人拒绝";
    }else if ([model.status isEqualToString:@"3"]){
        
        self.statusLa.text = @"已进入";
    }else if ([model.status isEqualToString:@"4"]){
        
        self.statusLa.text = @"已离开";
    }else if ([model.status isEqualToString:@"5"]){
        
        self.statusLa.text = @"拒绝进入";
    }
}

- (IBAction)onDetailBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDetailBtn:)]) {
        
        [self.delegate onDetailBtn:self.indexPath];
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
