//
//  XGDDetailCell.h
//  SecurityManager
//
//  Created by zhangming on 17/8/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGPointModel.h"

@interface XGDDetailCell : UITableViewCell

@property (strong, nonatomic) XGPointModel *model;

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) IBOutlet UILabel *titleLa;
@property (strong, nonatomic) IBOutlet UILabel *timeLa;
@property (strong, nonatomic) IBOutlet UILabel *noteLa;
@end
