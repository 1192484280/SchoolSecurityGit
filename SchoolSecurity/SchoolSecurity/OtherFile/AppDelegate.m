//
//  AppDelegate.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "AppDelegate.h"
#import "HeaderViewController.h"
#import "CacheManager.h"
#import "AFHTTPSessionManager.h"

#define AMapKey @"e8ab6778caaea680345d9e0bba534ce8"

#define ApiAK @"BAuh0rAw26bg6WglMCKAcAWO"

#define ApiSK @"CGmy1vZqbjbhnw53GK13OduGeEfDuM0M"

@interface AppDelegate ()

@end

@implementation AppDelegate

static AFHTTPSessionManager *manager ;

- (AFHTTPSessionManager *)sharedHTTPSession {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
        
    });
    return manager;
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:2];
    
    [HttpTool netWorkState:^(NSInteger netState) {
        switch (netState) {
            case 1:{
                NSLog(@"手机流量上网");
                [SingleClass sharedInstance].networkState = @"0";
                [CacheManager cacheOperation];
            }
                break;
            case 2:{
                NSLog(@"WIFI上网");
                [SingleClass sharedInstance].networkState = @"1";
                [CacheManager cacheOperation];
            }
                break;
            default:{
                NSLog(@"没网");
                [SingleClass sharedInstance].networkState = @"2";
            }
                break;
        }
    }];
    
    //注册高德地图
    [AMapServices sharedServices].apiKey = AMapKey;
    
    //注册百度ORC文字识别
    //[[AipOcrService shardService] authWithAK:ApiAK andSK:ApiSK];
    
    //键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //开启
    manager.enable = YES;
    //如果产品需要当键盘弹起时，点击背景收起键盘，也是一行代码解决。
    manager.shouldResignOnTouchOutside = YES;
    
    manager.enableAutoToolbar = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HeaderViewController *vc = [[HeaderViewController alloc]init];
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
    
    //打开数据库
    [[MyCoreDataManager sharedInstance] createCoredataDB:SecurityDB];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SchoolSecurity"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
