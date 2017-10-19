//
//  CacheManager.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/19.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "CacheManager.h"
#import "SGDJParameterModel.h"

#import "SecuritySGAgree+CoreDataProperties.h"

@implementation CacheManager


+ (void)cacheOperation{
    
    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[SecuritySGAgree class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
        
        [self doSomethingWithArr:coredataModelArr];
        
    } Error:^(NSError *error) {
        
    }];
}

+ (void)doSomethingWithArr:(NSArray *)arr{
    
    for (SecuritySGAgree *info in arr) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            SGDJParameterModel *model = (id)info;
            BaseStore *store = [[BaseStore alloc] init];
        
            [store ifLetGoWithSGDJParameterModel:model Success:^{
                
                //提交完成，删除数据库对应数据
                [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[SecuritySGAgree class] where:[NSString stringWithFormat:@"timeStamp = '%@'",info.timeStamp] result:^(BOOL isResult) {
                    
                } Error:^(NSError *error) {
                    
                }];
            } Failure:^(NSError *error) {
                
            }];
            
        });
    }
    
}
@end
