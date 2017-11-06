//
//  LookOtherCallerCell.h
//  SchoolSecurity
//
//  Created by zhangming on 2017/11/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherVisiterModel.h"

@interface LookOtherCallerCell : UITableViewCell

@property (strong, nonatomic) OtherVisiterModel *model;

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
