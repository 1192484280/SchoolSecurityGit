//
//  OtherDetailCell.h
//  SecurityManager
//
//  Created by zhangming on 17/9/11.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherDetailModel.h"

@interface OtherDetailCell : UITableViewCell

@property (strong, nonatomic) OtherDetailModel *model;

@property (strong, nonatomic) IBOutlet UILabel *La_name;

@property (strong, nonatomic) IBOutlet UILabel *La_idCard;

@property (strong, nonatomic) IBOutlet UILabel *La_gender;

@property (strong, nonatomic) IBOutlet UILabel *La_nation;

@property (strong, nonatomic) IBOutlet UILabel *La_birthday;

@property (strong, nonatomic) IBOutlet UILabel *La_address;

@property (strong, nonatomic) IBOutlet UILabel *La_part;

@property (strong, nonatomic) IBOutlet UILabel *La_date;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (instancetype)cell;

+ (CGFloat)getHeight;

@end
