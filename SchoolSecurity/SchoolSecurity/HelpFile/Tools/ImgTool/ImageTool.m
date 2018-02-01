//
//  ImageTool.m
//  ZENWork
//
//  Created by zhangming on 17/4/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ImageTool.h"

@implementation ImageTool


#pragma mark - 压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

#pragma mark 保存图片到document
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    // and then we write it out
    
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}

#pragma mark 从文档目录下获取Documents路径
+ (NSString *)documentFolderPath{
    
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
}

@end
