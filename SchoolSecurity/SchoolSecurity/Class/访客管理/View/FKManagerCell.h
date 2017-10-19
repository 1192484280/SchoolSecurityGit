//
//  FKManagerCell.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FKModel.h"

@protocol FKManagerCellDelegate <NSObject>

- (void)onLookDetailBtnWithIndex:(NSInteger)row;

@end

@interface FKManagerCell : UITableViewCell

@property (weak, nonatomic) id<FKManagerCellDelegate>delegate;

@property (assign, nonatomic) NSInteger rowOfCell;
@property (strong, nonatomic) IBOutlet UILabel *nameLa;
@property (strong, nonatomic) IBOutlet UILabel *telLa;

@property (strong, nonatomic) IBOutlet UILabel *numLa;

@property (strong, nonatomic) IBOutlet UILabel *dateLa;

@property (strong, nonatomic) FKModel *model;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)cell;

@end
