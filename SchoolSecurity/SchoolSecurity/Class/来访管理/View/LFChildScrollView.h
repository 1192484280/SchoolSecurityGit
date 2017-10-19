//
//  LFChildScrollView.h
//  SecurityManager
//
//  Created by zhangming on 17/8/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFChildScrollViewDelegate <NSObject>

- (void)scrollViewEndSlideWithIndex:(NSInteger)index;

@end

@interface LFChildScrollView : UIScrollView

@property (weak, nonatomic) id<LFChildScrollViewDelegate>myDelegate;

- (instancetype)initWithFrame:(CGRect)frame ChildViewControllers:(NSArray *)children MaxCount:(NSInteger)maxCount;

- (void)scrollViewWithIndex:(NSInteger)index;

@end
