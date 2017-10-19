//
//  PoliceBlackListCell.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoliceBlackListModel.h"

@protocol PoliceBlackListCellDelegate <NSObject>

- (void)onEditBtnWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface PoliceBlackListCell : UITableViewCell

@property (strong, nonatomic) id<PoliceBlackListCellDelegate>delegate;

@property (strong, nonatomic) PoliceBlackListModel *model;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UILabel *nameLa;

@property (strong, nonatomic) IBOutlet UILabel *idCardLa;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (instancetype)cell;

+ (CGFloat)getHeight;

@end
