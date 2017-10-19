//
//  ImgToBatManager.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ImgToBatManager.h"

@implementation ImgToBatManager

#pragma mark - 图片转bat64
+ (NSString *) image2DataURL: (UIImage *) image

{
    
    NSData *imageData = nil;
    
    NSString *mimeType = nil;
    
    
    if ([self imageHasAlpha: image]) {
        
        imageData = UIImagePNGRepresentation(image);
        
        mimeType = @"image/png";
        
    } else {
        
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        
        mimeType = @"image/jpeg";
        
    }
    
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
    
    
    
}

+ (BOOL) imageHasAlpha: (UIImage *) image
{
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    
    return (alpha == kCGImageAlphaFirst ||
            
            alpha == kCGImageAlphaLast ||
            
            alpha == kCGImageAlphaPremultipliedFirst ||
            
            alpha == kCGImageAlphaPremultipliedLast);
    
}


@end
