//
//  LFManagerCell.h
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFModel.h"

@protocol LFManagerCellDelegate <NSObject>

- (void)onDetailBtn:(NSIndexPath *)indexPath;

@end

@interface LFManagerCell : UITableViewCell

@property (weak, nonatomic) id<LFManagerCellDelegate>delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UILabel *visiterLa;

@property (strong, nonatomic) IBOutlet UILabel *callerLa;

@property (strong, nonatomic) IBOutlet UILabel *timeLa;

@property (strong, nonatomic) IBOutlet UILabel *reasonLa;

@property (strong, nonatomic) IBOutlet UILabel *statusLa;
@property (strong, nonatomic) LFModel *model;

+ (instancetype)tempWithTableView:(UITableView *)tableView;

+ (instancetype)cell;

+ (CGFloat)getHeight;

@end
