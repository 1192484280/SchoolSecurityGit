//
//  CacheManager.m
//  SchoolSecurity
//
//  Created by zhangming on 2017/10/19.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "CacheManager.h"
#import "SGDJParameterModel.h"
#import "ScanParameterModel.h"
#import "SecuritySGAgree+CoreDataProperties.h"
#import "SecurityScanAgree+CoreDataProperties.h"
#import "FKDC+CoreDataProperties.h"
#import "FKDetail+CoreDataProperties.h"
#import "ScanLogout+CoreDataProperties.h"

@implementation CacheManager


+ (void)cacheOperation{
    
    //手工放行缓存
    [self sgCache];
    
    //扫描放行/拒绝
    [self scanCache];

    //访客登出缓存
    [self fkdcCache];

    //扫描登出缓存
    [self scanLogout];
    
    //更新全部学校黑名单
    [self upSchoolBlackList];
    
    //更新全部公安黑名单
    [self upPoliceBlackList];
}

#pragma mark - 手工放行缓存
+ (void)sgCache{
    
    //检测有无缓存数据
    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[SecuritySGAgree class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
        
        //缓存数据执行网络操作
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

#pragma mark - 扫描放行拒绝缓存处理
+ (void)scanCache{
    
    //检测有无缓存数据
    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[SecurityScanAgree class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
        
        //缓存数据执行网络操作
        [self postScanCacheSomethingWithArr:coredataModelArr];
        
    } Error:^(NSError *error) {
        
    }];
}

+ (void)postScanCacheSomethingWithArr:(NSArray *)arr{
    
    for (SecurityScanAgree *info in arr) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            ScanParameterModel *model = (id)info;
            BaseStore *store = [[BaseStore alloc] init];
            
            [store ifLetGoWithParameterModel:model Success:^{
                
                //提交完成，删除数据库对应数据
                [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[SecurityScanAgree class] where:[NSString stringWithFormat:@"vr_id = '%@'",info.vr_id] result:^(BOOL isResult) {
                    
                } Error:^(NSError *error) {
                    
                }];
            } Failure:^(NSError *error) {
                
            }];
        });
    }
}


#pragma mark - 扫描登出缓存
+ (void)scanLogout{
    
    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[ScanLogout class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
       
        if (coredataModelArr.count > 0) {
            
            //缓存数据执行网络操作
            [self postScanLogoutCacheWithArr:coredataModelArr];
        }
    } Error:^(NSError *error) {
        
    }];
}
+ (void)postScanLogoutCacheWithArr:(NSArray *)arr{
    
    for (ScanLogout *info in arr) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BaseStore *store = [[BaseStore alloc] init];
        [store smLoginoutWithIdCard:info.idCard andSecurityId:info.securityId Success:^{
            
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[ScanLogout class] where:[NSString stringWithFormat:@"idCard = '%@'",info.idCard] result:^(BOOL isResult) {
                
            } Error:^(NSError *error) {
                
            }];
        } Failure:^(NSError *error) {
            
        }];
        
    });
    }
}


#pragma mark - 更新全部学校黑名单
+ (void)upSchoolBlackList{
    
    if ([UserDefaultsTool getSecurityId].length > 0) {
        
        BaseStore *store = [[BaseStore alloc] init];
        [store getAllSchoolBlackListWithSchoolId:[UserDefaultsTool getSecurityId] Success:^{
            
        } Failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark - 更新全部公安黑名单
+ (void)upPoliceBlackList{
    
    BaseStore *store = [[BaseStore alloc] init];
    [store getAllPoliceBlackListSuccess:^{
        
    } Failure:^(NSError *error) {
        
    }];
}

#pragma mark - 访客登出缓存
+ (void)fkdcCache{
    
    //检测有无缓存数据
    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[FKDC class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
        
        //将访客登出缓存数据上传
        [self postFKDCStoreWithArr:coredataModelArr];
        
    } Error:^(NSError *error) {
        
    }];
}

+ (void)postFKDCStoreWithArr:(NSArray *)arr{
    
    for (FKDC *info in arr) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            FKDC *model = (id)info;
            BaseStore *store = [[BaseStore alloc] init];
            [store fkLoginOutWithVr_Id:model.vr_id andSchoolId:info.schoolId andSecurityId:info.securityId Success:^{
                
                //提交完成，删除访客登出数据库对应数据
                [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[FKDC class] where:[NSString stringWithFormat:@"vr_id = '%@'",model.vr_id] result:^(BOOL isResult) {
                    
                } Error:^(NSError *error) {
                    
                }];
                
                
            } Failure:^(NSError *error) {
                
            }];
            
        });
    }
}
@end
