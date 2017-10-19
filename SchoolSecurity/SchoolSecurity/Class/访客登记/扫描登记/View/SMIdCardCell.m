//
//  SMIdCardCell.m
//  SecurityManager
//
//  Created by zhangming on 17/8/30.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SMIdCardCell.h"

@implementation SMIdCardCell

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identity = @"";
    
    switch (indexPath.section) {
        case 0:
            
            identity = @"CELL1";
            break;
            
        case 1:
            
            identity = @"CELL2";
            break;
        default:
            break;
    }
    
    SMIdCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        
        CLASSNAME
        cell = [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil][indexPath.section];
    }
    
    return cell;
}
+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self cellWithIndexPath:indexPath];
    return cell.frame.size.height;
    
}

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath{
    
    CLASSNAME
    return [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil][indexPath.section];
    
}

- (void)reciveInfoWithTitle:(NSString *)title andInfo:(NSString *)info{
    
    self.titleLa.text = title;
    self.infoLa.text = info;
}

- (IBAction)onSureBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSureBtn)]) {
        
        [self.delegate onSureBtn];
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
