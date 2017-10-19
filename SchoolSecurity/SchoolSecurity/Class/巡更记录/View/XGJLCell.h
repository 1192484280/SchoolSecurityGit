//
//  XGJLCell.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGJLModel.h"

@protocol XGJLCellDelegate <NSObject>

- (void)onDetailBtn:(NSIndexPath *)indexpath;

@end

@interface XGJLCell : UITableViewCell

@property (weak, nonatomic) id<XGJLCellDelegate>delegate;

@property (strong, nonatomic) XGJLModel *model;

@property (strong, nonatomic) NSIndexPath *indexPath;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (CGFloat)getHeight;

+ (instancetype)cell;

@property (strong, nonatomic) IBOutlet UILabel *timeLa;

@property (strong, nonatomic) IBOutlet UILabel *pointLa;

@property (strong, nonatomic) IBOutlet UILabel *rangeLa;
@end
