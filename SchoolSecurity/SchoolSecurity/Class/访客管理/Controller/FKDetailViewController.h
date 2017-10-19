//
//  FKDetailViewController.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"

@interface FKDetailViewController : BaseViewController

@property (nonatomic, copy) NSString *visitor_id;

@property (strong, nonatomic) IBOutlet UILabel *nameLa;

@property (strong, nonatomic) IBOutlet UILabel *idCardLa;

@property (strong, nonatomic) IBOutlet UILabel *genderLa;

@property (strong, nonatomic) IBOutlet UILabel *dateLa;

@end
