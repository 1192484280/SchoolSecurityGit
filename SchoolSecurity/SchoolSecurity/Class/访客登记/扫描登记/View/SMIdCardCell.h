//
//  SMIdCardCell.h
//  SecurityManager
//
//  Created by zhangming on 17/8/30.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMIdCardCellDelegate <NSObject>

- (void)onSureBtn;

@end

@interface SMIdCardCell : UITableViewCell

@property (assign, nonatomic) id<SMIdCardCellDelegate>delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLa;

@property (strong, nonatomic) IBOutlet UILabel *infoLa;
+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)getHeightWithIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath;

- (void)reciveInfoWithTitle:(NSString *)title andInfo:(NSString *)info;
@end
