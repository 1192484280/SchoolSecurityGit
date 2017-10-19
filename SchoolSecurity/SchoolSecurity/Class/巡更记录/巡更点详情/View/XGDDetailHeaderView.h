//
//  XGDDetailHeaderView.h
//  SecurityManager
//
//  Created by zhangming on 17/8/28.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGDetailModel.h"

@interface XGDDetailHeaderView : UIView

- (void)updateSubViewsWithScrollOffsetY:(CGFloat)y;

@property (strong, nonatomic) XGDetailModel *model;

@property (strong, nonatomic) IBOutlet UILabel *distanceLa;
@property (strong, nonatomic) IBOutlet UIImageView *headerIm;
@property (strong, nonatomic) IBOutlet UILabel *userNameLa;

@property (strong, nonatomic) IBOutlet UILabel *dateLa;
@end
