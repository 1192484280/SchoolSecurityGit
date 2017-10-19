//
//  CALayer+Addition.m
//  Take goods
//
//  Created by zhangming on 17/4/24.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)

- (UIColor *)borderUIColor {
    
    return objc_getAssociatedObject(self, @selector(borderUIColor));
    
}

-(void)setBorderUIColor:(UIColor *)color

{
    
    objc_setAssociatedObject(self, @selector(borderUIColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setBorderColorFromUI: self.borderUIColor];
    
}


- (void)setBorderColorFromUI:(UIColor *)color

{
    
    self.borderColor = color.CGColor;
    
    //    NSLog(@"%@", color);
    
    
    
}

@end
