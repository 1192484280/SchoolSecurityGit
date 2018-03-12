//
//  AppDelegate.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class AFHTTPSessionManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (AFHTTPSessionManager *)sharedHTTPSession;

@end

