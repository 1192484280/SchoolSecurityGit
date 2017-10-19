//
//  AVCaptureViewController.h
//  实时视频Demo
//
//  Created by zhongfeng1 on 2017/2/16.
//  Copyright © 2017年 zhongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IdInfoBlock)(void);

@interface AVCaptureViewController : BaseViewController

@property (nonatomic,assign) int type; //1:扫描登记，  2:手工登记,3：登出请求接口,4，来访管理

@property (strong , nonatomic) IdInfoBlock idInfoBlock;

- (void)returnText:(IdInfoBlock)block;

@end

