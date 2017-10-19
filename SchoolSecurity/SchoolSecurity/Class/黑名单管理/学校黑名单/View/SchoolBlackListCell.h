//
//  SchoolBlackListCell.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolBlackListModel.h"

@protocol SchoolBlackListCellDelegate <NSObject>

- (void)onEditBtnWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface SchoolBlackListCell : UITableViewCell

@property (strong, nonatomic) id<SchoolBlackListCellDelegate>delegate;

@property (strong, nonatomic) SchoolBlackListModel *model;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UILabel *nameLa;

@property (strong, nonatomic) IBOutlet UILabel *idCardLa;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (instancetype)cell;

+ (CGFloat)getHeight;

@end
