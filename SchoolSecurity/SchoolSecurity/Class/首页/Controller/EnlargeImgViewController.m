//
//  EnlargeImgViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/29.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "EnlargeImgViewController.h"

@interface EnlargeImgViewController ()<UIGestureRecognizerDelegate>

@end

@implementation EnlargeImgViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.headerImg.image = self.img;
    
    self.headerImg.contentMode = UIViewContentModeScaleAspectFit;
    //图像添加点击事件（手势方法）
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1;
    //手指数
    PrivateLetterTap.numberOfTapsRequired = 1;
    //tap次数
    PrivateLetterTap.delegate= self;
    self.view.contentMode = UIViewContentModeScaleToFill;
    [self.view addGestureRecognizer:PrivateLetterTap];
    
}

#pragma mark ---"头像"点击触发的方法，完成跳转
- (void)tapAvatarView:(UITapGestureRecognizer *)gesture {
    
    CATransition *animation = [CATransition animation];
    //    rippleEffect
    animation.type = @"rippleEffect";
    animation.subtype = @"fromBottom";
    animation.duration=  1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
