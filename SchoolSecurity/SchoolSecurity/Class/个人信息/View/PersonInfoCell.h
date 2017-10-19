//
//  PersonInfoCell.h
//  SecurityManager
//
//  Created by zhangming on 17/8/28.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonInfoCellDelegate <NSObject>

- (void)onHeaderBtn;
- (void)onSaveBtn;

@end

@interface PersonInfoCell : UITableViewCell

@property (weak, nonatomic) id<PersonInfoCellDelegate>delegate;

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) IBOutlet UIButton *headerBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLa;
@property (weak, nonatomic) IBOutlet UITextField *placeText;

+ (instancetype)tempWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)cellWidthIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)getHeightWidthIndexPath:(NSIndexPath *)indexPath;

@end
