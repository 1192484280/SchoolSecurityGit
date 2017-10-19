//
//  LoadingView.m
//  大麦
//
//  Created by 洪欣 on 16/12/16.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "LoadingView.h"
#import <Lottie/Lottie.h>

@interface LoadingView ()

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    LOTAnimationView *lottieTest = [LOTAnimationView animationNamed:@"trail_loading"];
    
    lottieTest.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    lottieTest.center = self.center;
    lottieTest.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:lottieTest];
    lottieTest.loopAnimation = true;
    [lottieTest play];
}

@end
