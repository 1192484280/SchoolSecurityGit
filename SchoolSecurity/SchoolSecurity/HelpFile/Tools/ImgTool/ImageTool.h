//
//  ImageTool.h
//  ZENWork
//
//  Created by zhangming on 17/4/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageTool : NSObject

#pragma mark - 压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

#pragma mark 保存图片到document
+ (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

#pragma mark 从文档目录下获取Documents路径
+ (NSString *)documentFolderPath;
@end
