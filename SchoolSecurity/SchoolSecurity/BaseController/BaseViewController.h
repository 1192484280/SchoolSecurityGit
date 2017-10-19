//
//  BaseViewController.h
//  ZENWork
//
//  Created by zhangming on 17/3/30.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BlackListType)
{
    SchoolBlackList = 0,
    PoliceBlackList
};

@interface BaseViewController : UIViewController

@property (assign, nonatomic) BlackListType blackListType;

@property (strong, nonatomic) LoadingView *loadingView;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (weak, nonatomic) UITextField *textFiled;


/**
 * 设置带返回按钮的页面标题
 */
- (void)setupBackBtnNavBarWithTitle:(NSString *)title;


/**
 * 添加loadingView
 */
- (void)addLoadingView;

/**
 * 移除loadingview
 */
- (void)removeLoadingView;


/**
 * 跳到登陆页面
 */
- (void)goLoginBlock:(void(^)())block;

- (void)back;

/**
 * 阴影
 */
- (void)addShownWithY:(CGFloat)y;



#pragma mark - MBProgress展示错误信息
- (void)showMBPError:(NSString *)msg;

#pragma mark - SVP展示错误信息
- (void)showSVPError:(NSString *)msg;

#pragma mark - SVP展示成功信息
- (void)showSVPSuccess:(NSString *)msg;



@end
