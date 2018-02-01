//
//  BaseStore.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseStore.h"
#import "CallerModel.h"
#import "CallerOrgModel.h"
#import "LFModel.h"
#import "OtherDetailModel.h"
#import "PoliceBlackListModel.h"
#import "SchoolBlackListModel.h"
#import "FKModel.h"
#import "XGJLModel.h"
#import "XGPointModel.h"
#import "PersonInfoModel.h"
#import "PersonList.h"
#import "OrgInfo+CoreDataProperties.h"
#import "CallerInfo+CoreDataProperties.h"
#import "FKManager+CoreDataProperties.h"
#import "FKDetail+CoreDataProperties.h"
#import "LFManager+CoreDataProperties.h"
#import "LFDetail+CoreDataProperties.h"
#import "XGJL+CoreDataProperties.h"
#import "XGDetail+CoreDataProperties.h"
#import "FWJL+CoreDataProperties.h"
#import "OtherPersonInfo+CoreDataProperties.h"
#import "AllSchoolBlack+CoreDataProperties.h"
#import "AllPoliceBlack+CoreDataProperties.h"


@implementation BaseStore

#pragma mark - 登陆
- (void)LoginWithAccount:(NSString *)account andPassWord:(NSString *)passWord Sucess:(void(^)(LoginUserModel *model))sucess failure:(void(^)(NSError *error))failure{
    
    //13591166695  111111
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/login",IP];
    
    NSDictionary *dic = @{
                          @"user_account":account,
                          @"password":passWord
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            LoginUserModel *model= [LoginUserModel mj_objectWithKeyValues:responseObject[@"data"]];
            sucess(model);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}


#pragma mark - 获取部门列表
- (void)getPartListWithSchoolId:(NSString *)school_id Success:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure{
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]){
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[OrgInfo class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
            
            success(coredataModelArr);
            
        } Error:^(NSError *error) {
            
        }];
        
        return;
    }
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"orglUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[OrgInfo class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/getOrgList",IP];
    
    NSDictionary *dic = @{
                          @"school_id":school_id
                          };
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSArray *arr = [CallerOrgModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            for (CallerOrgModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[OrgInfo class] where:[NSString stringWithFormat:@"org_id = %@",model.org_id] Alldata_arr:^(NSArray *coredataModelArr) {
                    
                    if(!(coredataModelArr.count >0)){
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[OrgInfo class] CoredataModel:^(OrgInfo * info) {
                            
                            info.org_id = model.org_id;
                            info.name = model.name;
                            
                        } Error:^(NSError *error) {
                            
                            
                        }];
                    }
                } Error:^(NSError *error) {
                    
                }];
                
            }
            
            success(arr);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}



#pragma mark - 获取受访人列表
- (void)getCallerListWithSchoolId:(NSString *)school_id andOrgId:(NSString *)org_id ArrSuccess:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure{
    
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[CallerInfo class] where:[NSString stringWithFormat:@"org_id = %@",org_id] Alldata_arr:^(NSArray *coredataModelArr) {
            
            success(coredataModelArr);
            
        } Error:^(NSError *error) {
            
        }];
        
        return;
    }
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"callerDetailUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[CallerInfo class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/getCallerList",IP];
    
    NSDictionary *dic = @{
                          @"school_id":school_id,
                          @"org_id":org_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSArray *arr = [CallerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            for (CallerModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[CallerInfo class] where:[NSString stringWithFormat:@"caller_id = %@",model.caller_id] Alldata_arr:^(NSArray *coredataModelArr) {
                    
                    if(!(coredataModelArr.count >0)){
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[CallerInfo class] CoredataModel:^(CallerInfo * info) {
                            
                            info.caller_id = model.caller_id;
                            info.org_id = model.org_id;
                            info.school_id = model.school_id;
                            info.name = model.name;
                            info.mphone = model.mphone;
                            info.tel = model.tel;
                            
                        } Error:^(NSError *error) {
                            
                            
                        }];
                    }
                } Error:^(NSError *error) {
                    
                }];
                
            }
            success(arr);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}

#pragma mark - 核实身份证信息
- (void)confirmIdCardWithIdCard:(NSString *)id_card andVrId:(NSString *)vr_id andVisiterId:(NSString *)visiter_id andSchoolId:(NSString *)school_id andSecuriyyId:(NSString *)security_personnel_id Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/checkIdCard",IP];
    
    NSDictionary *dic = @{
                          @"id_card":id_card,
                          @"vr_id":vr_id,
                          @"visitor_id":visiter_id,
                          @"school_id":school_id,
                          @"security_personnel_id":security_personnel_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


#pragma mark - 同意或拒绝放行
- (void)ifLetGoWithParameterModel:(ScanParameterModel *)model Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/visitingRecordsStatus",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:model.vr_id forKey:@"vr_id"];
    [dic setObject:model.status forKey:@"status"];
    
    if ([model.status isEqualToString: @"3"]) {
        
        [dic setObject:model.visitor_id forKey:@"visiter_id"];
        [dic setObject:model.school_id forKey:@"school_id"];
        [dic setObject:model.security_personnel_id forKey:@"security_personnel_id"];
        [dic setObject:model.id_card forKey:@"id_card"];
        [dic setObject:model.id_name forKey:@"id_name"];
        [dic setObject:model.id_sex forKey:@"id_sex"];
        [dic setObject:model.id_birthday forKey:@"id_birthday"];
        [dic setObject:model.id_address forKey:@"id_address"];
        [dic setObject:model.id_validity_date forKey:@"id_validity_date"];
        [dic setObject:model.id_nation forKey:@"id_nation"];
        [dic setObject:model.id_release_organ forKey:@"id_release_organ"];
        [dic setObject:model.is_other_person forKey:@"is_other_person"];
        [dic setObject:model.is_car forKey:@"is_car"];
        [dic setObject:model.visitor_tel forKey:@"visitor_tel"];
        
        [dic setObject:model.visitor_picture forKey:@"visitor_picture"];
        
        /*
         随行信息+车牌号
         */
        
        if ([model.is_car isEqualToString:@"1"]) {
            
            [dic setObject:model.plate_number forKey:@"plate_number"];
        }
        
        if (![model.is_other_person isEqualToString:@"0"]) {
            
            [dic setObject:model.other_person_list forKey:@"other_person_list"];
        }
        
    }
    
    
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        

        failure(error);
    }];
    
}

#pragma mark - 手工操作
- (void)ifLetGoWithSGDJParameterModel:(SGDJParameterModel *)model Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/addVisitingRecord",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:model.caller_id forKey:@"caller_id"];
    [dic setObject:model.org_id forKey:@"org_id"];
    [dic setObject:model.school_id forKey:@"school_id"];
    [dic setObject:model.security_personnel_id forKey:@"security_personnel_id"];
    [dic setObject:model.status forKey:@"status"];
    [dic setObject:model.id_card forKey:@"id_card"];
    [dic setObject:model.id_name forKey:@"id_name"];
    [dic setObject:model.id_sex forKey:@"id_sex"];
    [dic setObject:model.id_birthday forKey:@"id_birthday"];
    [dic setObject:model.id_address forKey:@"id_address"];
    [dic setObject:model.id_validity_date forKey:@"id_validity_date"];
    [dic setObject:model.id_nation forKey:@"id_nation"];
    [dic setObject:model.id_release_organ forKey:@"id_release_organ"];
    [dic setObject:model.is_other_person forKey:@"is_other_person"];
    [dic setObject:model.is_car forKey:@"is_car"];
    [dic setObject:model.visitor_tel forKey:@"visitor_tel"];
    [dic setObject:model.visitor_picture forKey:@"visitor_picture"];
    
    /*
     随行信息+车牌号
     */
    if ([model.is_car isEqualToString:@"1"]) {
        
        [dic setObject:model.plate_number forKey:@"plate_number"];
    }
    
    if (![model.is_other_person isEqualToString:@"0"]) {
        
        [dic setObject:model.other_person_list forKey:@"other_person_list"];
    }
    
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        failure(error);
    }];
}

#pragma mark - 扫描身份证登出
- (void)smLoginoutWithIdCard:(NSString *)IdCard andSecurityId:(NSString *)securityId Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/leaveSchool",IP];
    
    NSDictionary *dic = @{
                          @"id_card":IdCard,
                          @"logout_security_personnel_id":securityId
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
        
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 获取来访列表
- (void)getLFManagerListWithParametersModel:(LFParametersModel *)paraModel Success:(void(^)(NSArray *arr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/visitingRecords",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:paraModel.school_id forKey:@"school_id"];
    [dic setObject:paraModel.page forKey:@"page"];
    if (paraModel.visitor_id.length >0) {
        
        [dic setObject:paraModel.visitor_id forKey:@"visitor_id"];
    }
    
    if (paraModel.status.length > 0) {
        
        [dic setObject:paraModel.status forKey:@"status"];
    }
    
    if (paraModel.id_name.length > 0) {
        
        [dic setObject:paraModel.id_name forKey:@"id_name"];
    }
    
    if (paraModel.visitor_tel.length >0) {
        
        [dic setObject:paraModel.visitor_tel forKey:@"visitor_tel"];
    }
    
    if (paraModel.caller_name.length > 0) {
        
        [dic setObject:paraModel.caller_name forKey:@"caller_name"];
    }
    
    if (paraModel.caller_tel.length > 0) {
        
        [dic setObject:paraModel.caller_tel forKey:@"caller_tel"];
    }
    
    if (paraModel.visitor_time_start.length > 0) {
        
        [dic setObject:paraModel.visitor_time_start forKey:@"visitor_time_start"];
    }
    
    if (paraModel.visitor_time_end.length > 0) {
        
        [dic setObject:paraModel.visitor_time_end forKey:@"visitor_time_end"];
    }
    
    if (paraModel.login_time_start.length > 0) {
        
        [dic setObject:paraModel.login_time_start forKey:@"login_time_start"];
    }
    
    if (paraModel.login_time_end.length > 0) {
        
        [dic setObject:paraModel.login_time_end forKey:@"login_time_end"];
    }
    
    if (paraModel.status){
        
        //网络正常时，超过八小时，重置数据库
        NSString *key = @"lfListUpDate";
        NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
        
        if (!upDateStr) {
            
            [self upDateForKey:key];
        }else{
            
            NSTimeInterval upDate = upDateStr.doubleValue;
            NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
            
            if (now - upDate > 8*60*60) {
                
                [self upDateForKey:key];
                
                [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[LFManager class] where:nil result:^(BOOL isResult) {
                    
                    
                } Error:^(NSError *error) {
                    
                }];
                
            }
        }
        
        [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
            
            
            
            NSError *error = [HttpTool inspectError:responseObject];
            if (error == nil) {
                
                BOOL haveMore = YES;
                
                NSArray *arr  = [LFModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                
                for (LFModel *model in arr) {
                    
                    //访问管理添加数据
                    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[LFManager class] where:[NSString stringWithFormat:@"vr_id = %@",model.vr_id] Alldata_arr:^(NSArray *coredataModelArr) {
                        
                        if (!(coredataModelArr.count >0)) {
                            
                            [MyCoreDataManager inserDataWith_CoredatamodelClass:[LFManager class] CoredataModel:^(LFManager *info) {
                                
                                info.format_visitor_time = model.format_visitor_time;
                                info.note = model.note;
                                info.status = model.status;
                                info.vr_id = model.vr_id;
                                info.visitor_name = model.visitor_name;
                                info.visitor_tel = model.visitor_tel;
                                info.caller_name = model.caller_name;
                                info.caller_tel = model.caller_tel;
                                
                            } Error:^(NSError *error) {
                                
                            }];
                        }
                    } Error:^(NSError *error) {
                        
                    }];
                    
                }
                
                
                if ( !(arr.count >0)) {
                    
                    haveMore = NO;
                }
                success(arr, haveMore);
            }else{
                
                failure(error);
            }
            
        } failure:^(NSError *error) {
            
            failure(error);
        }];
        
    }else{
        
        //网络正常时，超过八小时，重置数据库
        NSString *key = @"fwjlListUpDate";
        NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
        
        if (!upDateStr) {
            
            [self upDateForKey:key];
        }else{
            
            NSTimeInterval upDate = upDateStr.doubleValue;
            NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
            
            if (now - upDate > 8*60*60) {
                
                [self upDateForKey:key];
                
                [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[FWJL class] where:nil result:^(BOOL isResult) {
                    
                    
                } Error:^(NSError *error) {
                    
                }];
                
            }
        }
        
        [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
            
            NSError *error = [HttpTool inspectError:responseObject];
            if (error == nil) {
                
                BOOL haveMore = YES;
                
                NSArray *arr  = [LFModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
                
                for (LFModel *model in arr) {
                    
                    //访问管理添加数据
                    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[FWJL class] where:[NSString stringWithFormat:@"vr_id = %@",model.vr_id] Alldata_arr:^(NSArray *coredataModelArr) {
                        
                        if (!(coredataModelArr.count >0)) {
                            
                            [MyCoreDataManager inserDataWith_CoredatamodelClass:[FWJL class] CoredataModel:^(FWJL *info) {
                                
                                info.visitor_id = paraModel.visitor_id;
                                info.format_visitor_time = model.format_visitor_time;
                                info.note = model.note;
                                info.status = model.status;
                                info.vr_id = model.vr_id;
                                info.visitor_name = model.visitor_name;
                                info.visitor_tel = model.visitor_tel;
                                info.caller_name = model.caller_name;
                                info.caller_tel = model.caller_tel;
                                
                            } Error:^(NSError *error) {
                                
                            }];
                        }
                    } Error:^(NSError *error) {
                        
                    }];
                    
                }
                
                
                if ( !(arr.count >0)) {
                    
                    haveMore = NO;
                }
                success(arr, haveMore);
            }else{
                
                failure(error);
            }
            
        } failure:^(NSError *error) {
            
            failure(error);
        }];
        
    }
    
}

- (void)upDateForKey:(NSString *)key{
    
    [UserDefaultsTool setObj:[NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]] andKey:key];
}


#pragma mark - 获取来访详情信息
- (void)getLFDetailInfoWithVr_id:(NSString *)vr_id Success:(void(^)(LFDetailModel *model))success Failure:(void(^)(NSError *error))failure{
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[LFDetail class] where:[NSString stringWithFormat:@"vr_id = '%@'",vr_id] Alldata_arr:^(NSArray *coredataModelArr) {
            
            if (coredataModelArr.count > 0) {
                
                success(coredataModelArr[0]);
            }else{
                
                failure(nil);
            }
            
        } Error:^(NSError *error) {
            
        }];
        
        return;
    }
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"lfDetailUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[LFDetail class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/visitingRecordDetail",IP];
    
    NSDictionary *dic = @{
                          @"vr_id":vr_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            LFDetailModel *model = [LFDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            [MyCoreDataManager selectDataWith_CoredatamoldeClass:[LFDetail class] where:[NSString stringWithFormat:@"vr_id = '%@'",model.vr_id] Alldata_arr:^(NSArray *coredataModelArr) {
                
                if (!(coredataModelArr.count > 0)) {
                    
                    [MyCoreDataManager inserDataWith_CoredatamodelClass:[LFDetail class] CoredataModel:^(LFDetail *info) {
                        
                        info.vr_id = model.vr_id;
                        info.format_visitor_time = model.format_visitor_time;
                        info.visitor_id = model.visitor_id;
                        info.caller_id = model.caller_id;
                        info.is_car = model.is_car;
                        info.plate_number = model.plate_number;
                        info.is_other_person = model.is_other_person;
                        info.note = model.note;
                        info.visitor_status = model.visitor_status;
                        info.caller_name = model.caller_name;
                        info.caller_mphone = model.caller_mphone;
                        info.caller_tel = model.caller_tel;
                        info.org_name = model.org_name;
                        info.school_name = model.school_name;
                        info.visitor_name = model.visitor_name;
                        info.visitor_tel = model.visitor_tel;
                        info.visitor_id_card = model.visitor_id_card;
                        info.visitor_picture = model.visitor_picture;
                        
                    } Error:^(NSError *error) {
                        
                    }];
                }
                
            } Error:^(NSError *error) {
                
            }];
            
            success(model);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 获取随行人员详细数组
- (void)getOtherListArrWithVr_id:(NSString *)vr_id Success:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure{
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[OtherPersonInfo class] where:[NSString stringWithFormat:@"vr_id = '%@'",vr_id] Alldata_arr:^(NSArray *coredataModelArr) {
           
            if (coredataModelArr.count > 0) {
                
                success(coredataModelArr);
            }else{
                
                failure(nil);
            }
        } Error:^(NSError *error) {
            
        }];
        return;
    }
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"OtherPersonUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[OtherPersonInfo class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/otherVisitingRecordPerson",IP];
    
    NSDictionary *dic = @{
                          @"vr_id":vr_id
                          };
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSArray *arr = [OtherDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            for (OtherDetailModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[OtherPersonInfo class] where:[NSString stringWithFormat:@"vrop_id= '%@'",model.vrop_id] Alldata_arr:^(NSArray *coredataModelArr) {
                    
                    if (!(coredataModelArr.count > 0)) {
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[OtherPersonInfo class] CoredataModel:^(OtherPersonInfo *info) {
                            
                            info.vrop_id = model.vrop_id;
                            info.visitor_picture = model.visitor_picture;
                            info.id_card = model.id_card;
                            info.id_name = model.id_name;
                            info.id_sex = model.id_sex;
                            info.id_birthday = model.id_birthday;
                            info.id_address = model.id_address;
                            info.id_validity_date = model.id_validity_date;
                            info.id_nation = model.id_nation;
                            info.id_release_organ = model.id_release_organ;
                            info.vr_id = model.vr_id;
                            
                        } Error:^(NSError *error) {
                            
                        }];
                    }
                } Error:^(NSError *error) {
                    
                }];
            }
            success(arr);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


#pragma mark - 访客登出
- (void)fkLoginOutWithVr_Id:(NSString *)vr_id andSchoolId:(NSString *)schoolId andSecurityId:(NSString *)securityId Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/visitorLogout",IP];
    
    NSDictionary *dic = @{
                          @"vr_id":vr_id,
                          @"school_id":schoolId,
                          @" logout_security_personnel_id":securityId,
                          @"leave_type":@"2",
                          @"status":@"3"
                          };
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            
            success();
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


#pragma mark - 获取公安黑名单
- (void)getPoliceBlackListWithPage:(NSString *)page Succes:(void(^)(NSArray *arr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/policeBlackList",IP];
    
    NSDictionary *dic = @{
                          @"page":page
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            BOOL haveMore = YES;
            
            NSArray *arr  = [PoliceBlackListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            for (PoliceBlackListModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[AllPoliceBlack class] where:[NSString stringWithFormat:@"pbl_id = '%@'",model.pbl_id] Alldata_arr:^(NSArray *coredataModelArr) {
                    
                    if (!(coredataModelArr.count > 0)) {
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[AllPoliceBlack class] CoredataModel:^(AllPoliceBlack *info) {
                            
                            info.pbl_id = model.pbl_id;
                            info.name = model.name;
                            info.id_card = model.id_card;
                            info.note = model.note;
                            
                        } Error:^(NSError *error) {
                            
                        }];
                    }
                } Error:^(NSError *error) {
                    
                }];
            }
            
            if ( !(arr.count >0)) {
                
                haveMore = NO;
            }
            
            success(arr, haveMore);
            
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


#pragma mark - 获取学校黑名单列表
- (void)getSchoolBlackListWithSchoolID:(NSString *)schoolId andPage:(NSString *)page Succes:(void(^)(NSArray *arr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/schoolBlackList",IP];
    
    NSDictionary *dic = @{
                          @"school_id":schoolId,
                          @"page":page
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            BOOL haveMore = YES;
            
            NSArray *arr  = [SchoolBlackListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            for (SchoolBlackListModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[AllSchoolBlack class] where:[NSString stringWithFormat:@"bl_id = '%@'",model.bl_id] Alldata_arr:^(NSArray *coredataModelArr) {
                    
                    if (!(coredataModelArr.count > 0)) {
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[AllSchoolBlack class] CoredataModel:^(AllSchoolBlack *info) {
                            
                            info.bl_id = model.bl_id;
                            info.name = model.name;
                            info.school_id = model.school_id;
                            info.id_card = model.id_card;
                            info.note = model.note;
                        } Error:^(NSError *error) {
                            
                        }];
                    }
                } Error:^(NSError *error) {
                    
                }];
            }
            
            if ( !(arr.count >0)) {
                
                haveMore = NO;
            }
            
            
            success(arr, haveMore);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}

#pragma mark - 添加黑名单
- (void)addBlackListWithSchoolId:(NSString *)school_id andIdCard:(NSString *)idCard andName:(NSString *)name andNote:(NSString *)note andType:(BlackListType)type Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString string];
    NSDictionary *dic = [NSDictionary dictionary];
    
    if (type == SchoolBlackList) {
        
        url = [NSString stringWithFormat:@"%@/api/Api/addBlack",IP];
        dic = @{
                @"school_id":school_id,
                @"name":name,
                @"id_card":idCard,
                @"note":note
                };
        
    }else{
        
        url = [NSString stringWithFormat:@"%@/api/Api/addPoliceBlack",IP];
        dic = @{
                @"name":name,
                @"id_card":idCard,
                @"note":note
                };
    }
    
    
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        if (error == nil) {
            
            //刷新全部黑名单
            if (type == SchoolBlackList) {
                
                [self getAllSchoolBlackListWithSchoolId:school_id Success:^{
                    
                } Failure:^(NSError *error) {
                    
                }];
            }else{
                
                [self getAllPoliceBlackListSuccess:^{
                    
                } Failure:^(NSError *error) {
                    
                }];
            }
            
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


#pragma mark - 编辑黑名单
- (void)editBlackListWithParameterId:(NSString  *)Id andSchoolId:(NSString *)school_id andName:(NSString *)name andIdCard:(NSString *)idCard andNote:(NSString *)note andType:(BlackListType)type Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString string];
    NSDictionary *dic = [NSDictionary dictionary];
    
    if (type == SchoolBlackList) {
        
        url = [NSString stringWithFormat:@"%@/api/Api/editBlack",IP];
        dic = @{
                @"school_id":school_id,
                @"name":name,
                @"id_card":idCard,
                @"note":note,
                @"bl_id":Id
                };
        
    }else{
        
        url = [NSString stringWithFormat:@"%@/api/Api/editPoliceBlack",IP];
        dic = @{
                @"name":name,
                @"id_card":idCard,
                @"note":note,
                @"pbl_id":Id
                };
    }
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            //刷新全部黑名单
            if (type == SchoolBlackList) {
                
                [MyCoreDataManager updataDataWith_CoredatamoldeClass:[AllSchoolBlack class] where:[NSString stringWithFormat:@"bl_id = '%@'",Id] result:^(AllSchoolBlack *info) {
                    
                    info.bl_id = Id;
                    info.school_id = school_id;
                    info.name = name;
                    info.id_card = idCard;
                    info.note = note;
                    NSLog(@"");
                    
                } Error:^(NSError *error) {
                    
                }];
                
            }else{
                
                [MyCoreDataManager updataDataWith_CoredatamoldeClass:[AllPoliceBlack class] where:[NSString stringWithFormat:@"pbl_id = '%@'",Id] result:^(AllPoliceBlack *info) {
                    
                    info.pbl_id = Id;
                    info.name = name;
                    info.id_card = idCard;
                    info.note = note;
                    NSLog(@"");
                    
                } Error:^(NSError *error) {
                    
                }];
            }
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}


#pragma mark - 删除黑名单
- (void)deleteBlackListWithId:(NSString *)Id andType:(BlackListType)type Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString string];
    NSDictionary *dic = [NSDictionary dictionary];
    
    if (type == SchoolBlackList) {
        
        url = [NSString stringWithFormat:@"%@/api/Api/removeBlack",IP];
        dic = @{
                @"bl_id":Id
                };
        
    }else{
        
        url = [NSString stringWithFormat:@"%@/api/Api/removePoliceBlack",IP];
        dic = @{
                @"pbl_id":Id
                };
    }
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            //刷新全部黑名单
            if (type == SchoolBlackList) {
                
                [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[AllSchoolBlack class] where:[NSString stringWithFormat:@"bl_id = '%@'",Id] result:^(BOOL isResult) {
                    
                } Error:^(NSError *error) {
                    
                }];
            }else{
                
                [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[AllPoliceBlack class] where:[NSString stringWithFormat:@"pbl_id = '%@'",Id] result:^(BOOL isResult) {
                    
                } Error:^(NSError *error) {
                    
                }];
            }
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

#pragma mark - 获取访客管理列表
-(void)getFKManagerListArrWithParameter:(FKParameterModel *)model Success:(void(^)(NSArray *arr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"fkManagerUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[FKManager class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/visitorList",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:model.school_id forKey:@"school_id"];
    [dic setObject:model.page forKey:@"page"];
    
    if (model.name.length > 0) {
        
        [dic setObject:model.name forKey:@"name"];
    }
    if (model.visitor_tel.length > 0) {
        
        [dic setObject:model.visitor_tel forKey:@"visitor_tel"];
    }
    
    if (model.sex.length >0) {
        
        [dic setObject:model.sex forKey:@"sex"];
    }
    
    if (model.srtart_login_time.length >0) {
        
        [dic setObject:model.srtart_login_time forKey:@"srtart_login_time"];
    }
    
    if (model.end_login_time.length > 0) {
        
        [dic setObject:model.end_login_time forKey:@"end_login_time"];
    }
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            BOOL haveMore = YES;
            
            NSArray *arr  = [FKModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            for (FKModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[FKManager class] where:[NSString stringWithFormat:@"visitor_id = '%@'",model.visitor_id] Alldata_arr:^(NSArray *coredataModelArr) {
                    
                    if (!(coredataModelArr.count > 0)) {
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[FKManager class] CoredataModel:^(FKManager *info) {
                            
                            info.id_name = model.id_name;
                            info.visitor_tel = model.visitor_tel;
                            info.visitor_time = model.visitor_time;
                            info.visits_number = model.visits_number;
                            info.id_card = model.id_card;
                            info.visitor_id = model.visitor_id;
                            
                        } Error:^(NSError *error) {
                            
                        }];
                    }
                } Error:^(NSError *error) {
                    
                }];
            }
            
            if ( !(arr.count >0)) {
                
                haveMore = NO;
            }
            success(arr,haveMore);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


#pragma mark - 访客详情
- (void)getDetailInfoWithVisitor_id:(NSString *)visitor_id Success:(void(^)(FKDetailMode *model))success Failure:(void(^)(NSError *error))failure{
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[FKDetail class] where:[NSString stringWithFormat:@"visitor_id = '%@'",visitor_id] Alldata_arr:^(NSArray *coredataModelArr) {
            
            if (coredataModelArr.count >0) {
                
                success(coredataModelArr[0]);
            }else{
                
                failure(nil);
            }
            
        } Error:^(NSError *error) {
            
        }];
        return;
    }
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"fkDetailUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[FKDetail class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/visitorDetail",IP];
    
    NSDictionary *dic = @{
                          @"visitor_id":visitor_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            FKDetailMode *model  = [FKDetailMode mj_objectWithKeyValues:responseObject[@"data"]];
            
            [MyCoreDataManager selectDataWith_CoredatamoldeClass:[FKDetail class] where:[NSString stringWithFormat:@"visitor_id = '%@'",model.visitor_id] Alldata_arr:^(NSArray *coredataModelArr) {
                
                if (!(coredataModelArr.count >0)) {
                    
                    [MyCoreDataManager inserDataWith_CoredatamodelClass:[FKDetail class] CoredataModel:^(FKDetail *info) {
                       
                        info.visitor_id = model.visitor_id;
                        info.name = model.name;
                        info.sex = model.sex;
                        info.tel = model.tel;
                        info.id_card = model.id_card;
                        info.status = model.status;
                        info.wx_id = model.wx_id;
                        info.school_list = model.school_list;
                        info.birthday = model.birthday;
                        
                    } Error:^(NSError *error) {
                        
                    }];
                }
                
            } Error:^(NSError *error) {
                
            }];
            success(model);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        failure(error);
    }];
}


#pragma mark - 巡更列表
- (void)getXGLBWithSchoolId:(NSString *)schoolId andSecurityId:(NSString *)securityId andPage:(NSString *)page Success:(void(^)(NSArray *listArr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure{
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"xgListUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[XGJL class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/patrolList",IP];
    
    NSDictionary *dic = @{
                          @"school_id":schoolId,
                          @"security_personnel_id":securityId,
                          @"page":page
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
    
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            BOOL haveMore = YES;
            
            NSArray *arr  = [XGJLModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            for (XGJLModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[XGJL class] where:[NSString stringWithFormat:@"p_id = '%@'",model.p_id] Alldata_arr:^(NSArray *coredataModelArr) {
                   
                    if (!(coredataModelArr.count > 0)) {
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[XGJL class] CoredataModel:^(XGJL *info) {
                            
                            info.p_id = model.p_id;
                            info.patrol_time = model.patrol_time;
                            info.psr_number = model.psr_number;
                            info.distance = model.distance;
                            
                        } Error:^(NSError *error) {
                            
                        }];
                    }
                    
                } Error:^(NSError *error) {
                    
                }];
            }
            
            if ( !(arr.count >0)) {
                
                haveMore = NO;
            }
            success(arr,haveMore);
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
    
}

#pragma mark - 巡更详情
- (void)getXGDetailWithP_id:(NSString *)p_id Success:(void(^)(XGDetailModel *model))success Failure:(void(^)(NSError *error))failure{
    
    if ([[SingleClass sharedInstance].networkState isEqualToString:@"2"]) {
        
        [MyCoreDataManager selectDataWith_CoredatamoldeClass:[XGDetail class] where: [NSString stringWithFormat:@"p_id = '%@'",p_id] Alldata_arr:^(NSArray *coredataModelArr) {
            
            if (coredataModelArr.count > 0) {
                
                XGDetail *detail = coredataModelArr[0];
                
                XGDetailModel *model = [[XGDetailModel alloc] init];

                model.distance = detail.distance;
                model.headimg = detail.headimg;
                model.line = [NSKeyedUnarchiver unarchiveObjectWithData:detail.line];
                model.p_id = detail.p_id;
                model.patrol_add_time = detail.patrol_add_time;
                model.patrol_end_time = detail.patrol_end_time;
                model.security_personnel_id = detail.security_personnel_id;
                model.sp_name = detail.sp_name;
                model.psr_info = [NSKeyedUnarchiver unarchiveObjectWithData:detail.psr_info];
                success(model);
            }else{
                
                failure(nil);
            }
        } Error:^(NSError *error) {
            
        }];
        
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/patrolDetail",IP];
    
    NSDictionary *dic = @{
                          @"p_id":p_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            XGDetailModel *model = [XGDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            [MyCoreDataManager selectDataWith_CoredatamoldeClass:[XGDetail class] where:[NSString stringWithFormat:@"p_id = '%@'",model.p_id] Alldata_arr:^(NSArray *coredataModelArr) {
                
                if (!(coredataModelArr.count > 0)) {
                    
                    [MyCoreDataManager inserDataWith_CoredatamodelClass:[XGDetail class] CoredataModel:^(XGDetail *info) {
                        
                        info.psr_info = [NSKeyedArchiver archivedDataWithRootObject:model.psr_info];
                        info.distance = model.distance;
                        info.headimg = model.headimg;
                        info.line = [NSKeyedArchiver archivedDataWithRootObject:model.line];
                        info.p_id = model.p_id;
                        info.patrol_add_time = model.patrol_add_time;
                        info.patrol_end_time = model.patrol_end_time;
                        info.security_personnel_id = model.security_personnel_id;
                        info.sp_name = model.sp_name;
                        
                    } Error:^(NSError *error) {
                        
                    }];
                    
                }
            } Error:^(NSError *error) {
                
            }];
            
            success(model);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}


#pragma mark - 获取个人信息
-(void)getPersonInfoWithSchoolId:(NSString *)school_id andSecurityId:(NSString *)securityId Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/getSecurityPersonnel",IP];
    
    NSDictionary *dic = @{
                          @"school_id":school_id,
                          @"security_personnel_id":securityId
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            PersonInfoModel *personModel = [PersonInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            [PersonList sharedInstance].personModel = personModel;
            
            [UserDefaultsTool setObj:personModel.name andKey:@"userName"];
            [UserDefaultsTool setObj:personModel.id_card andKey:@"id_card"];
            [UserDefaultsTool setObj:personModel.mphone andKey:@"mphone"];
            [UserDefaultsTool setObj:personModel.headimg andKey:@"userHeadimg"];
            
            success();
            
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        failure(error);
    }];
}

#pragma mark - 修改个人信息
- (void)changePersonInfoWithParameter:(PersonParameterModel *)parameter Success:(void (^)())success Failure:(void (^)(NSError *))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/editSecurityPersonnel",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:parameter.security_personnel_id forKey:@"security_personnel_id"];
    
    if (parameter.name.length > 0) {
        
        [dic setObject:parameter.name forKey:@"name"];
    }
    
    if (parameter.id_card.length > 0) {
        
        [dic setObject:parameter.id_card forKey:@"id_card"];
    }
    
    if (parameter.mphone.length > 0) {
        
        [dic setObject:parameter.mphone forKey:@"mphone"];
    }
    
    if (parameter.headimg.length > 0) {
        
        [dic setObject:parameter.headimg forKey:@"headimg"];
    }
    
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
       
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        failure(error);
    }];
}

 
#pragma mark - 开始巡更
- (void)startXGWithSchoolId:(NSString *)school_id andSecurityId:(NSString *)security_id Success:(void(^)(NSString *p_id))success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/startPatrol",IP];
    
    NSDictionary *dic = @{
                          @"school_id":school_id,
                          @"security_personnel_id":security_id
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSString *p_id = responseObject[@"data"][@"p_id"];
            success(p_id);
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}


#pragma mark - 结束巡更
- (void)endXGWithSchoolId:(NSString *)school_id andSecurityId:(NSString *)security_id andP_id:(NSString *)p_id andLine:(NSString *)line andDistance:(NSString *)distance Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/endPatrol",IP];
    
    NSDictionary *dic = @{
                          @"school_id":school_id,
                          @"security_personnel_id":security_id,
                          @"p_id":p_id,
                          @"line":line,
                          @"distance":distance
                          };
    
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}


#pragma mark - 添加巡更扫描点
- (void)addXGPointWithPs_id:(NSString *)ps_id andSecurityId:(NSString *)securityId andP_id:(NSString *)p_id andNote:(NSString *)note Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/addPsr",IP];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:ps_id forKey:@"ps_id"];
    [dic setObject:p_id forKey:@"p_id"];
    [dic setObject:@"1" forKey:@"status"];
    [dic setObject:securityId forKey:@"security_personnel_id"];
    
    if (note.length > 0) {
        
        [dic setObject:note forKey:@"note"];
    }
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            success();
        }else{
            
            failure(error);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

#pragma mark - 获取全部学校黑名单
- (void)getAllSchoolBlackListWithSchoolId:(NSString *)school_id Success:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/allSchoolBlackList",IP];
    
    NSDictionary *dic = @{
                          @"school_id":school_id
                          };
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"schoolBlackListUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
        
        [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
            
            NSError *error = [HttpTool inspectError:responseObject];
            
            if (error == nil) {
                
                NSArray *arr  = [SchoolBlackListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                
                for (SchoolBlackListModel *model in arr) {
                    
                    [MyCoreDataManager selectDataWith_CoredatamoldeClass:[AllSchoolBlack class] where:[NSString stringWithFormat:@"bl_id = '%@'",model.bl_id] Alldata_arr:^(NSArray *coredataModelArr) {
                        
                        if (!(coredataModelArr.count > 0)) {
                            
                            [MyCoreDataManager inserDataWith_CoredatamodelClass:[AllSchoolBlack class] CoredataModel:^(AllSchoolBlack *info) {
                                
                                info.bl_id = model.bl_id;
                                info.school_id = model.school_id;
                                info.name = model.name;
                                info.id_card = model.id_card;
                                info.note = model.note;
                                
                            } Error:^(NSError *error) {
                                
                            }];
                        }
                    } Error:^(NSError *error) {
                        
                    }];
                }
                success();
            }else{
                
                failure(error);
            }
            
        } failure:^(NSError *error) {
            
            failure(error);
        }];
        
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[AllSchoolBlack class] where:nil result:^(BOOL isResult) {
                
                [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
                    
                    NSError *error = [HttpTool inspectError:responseObject];
                    
                    if (error == nil) {
                        
                        NSArray *arr  = [SchoolBlackListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                        
                        for (SchoolBlackListModel *model in arr) {
                            
                            [MyCoreDataManager selectDataWith_CoredatamoldeClass:[AllSchoolBlack class] where:[NSString stringWithFormat:@"bl_id = '%@'",model.bl_id] Alldata_arr:^(NSArray *coredataModelArr) {
                                
                                if (!(coredataModelArr.count > 0)) {
                                    
                                    [MyCoreDataManager inserDataWith_CoredatamodelClass:[AllSchoolBlack class] CoredataModel:^(AllSchoolBlack *info) {
                                        
                                        info.bl_id = model.bl_id;
                                        info.school_id = model.school_id;
                                        info.name = model.name;
                                        info.id_card = model.id_card;
                                        info.note = model.note;
                                        
                                    } Error:^(NSError *error) {
                                        
                                    }];
                                }
                            } Error:^(NSError *error) {
                                
                            }];
                        }
                        success();
                    }else{
                        
                        failure(error);
                    }
                    
                } failure:^(NSError *error) {
                    
                    failure(error);
                }];
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }

}


#pragma mark - 获取全部公安黑名单
- (void)getAllPoliceBlackListSuccess:(void(^)())success Failure:(void(^)(NSError *error))failure{
    
    
    //网络正常时，超过八小时，重置数据库
    NSString *key = @"policeBlackListUpDate";
    NSString *upDateStr = [UserDefaultsTool getObjWithKey:key];
    
    if (!upDateStr) {
        
        [self upDateForKey:key];
    }else{
        
        NSTimeInterval upDate = upDateStr.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        
        if (now - upDate > 8*60*60) {
            
            [self upDateForKey:key];
            
            //如果大于8小时，就重置数据库
            [MyCoreDataManager deleteDataWith_CoredatamoldeClass:[AllPoliceBlack class] where:nil result:^(BOOL isResult) {
                
                
            } Error:^(NSError *error) {
                
            }];
            
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/api/Api/policeBlackList",IP];

    [HttpTool getUrlWithString:url parameters:nil success:^(id responseObject) {
        
        NSError *error = [HttpTool inspectError:responseObject];
        
        if (error == nil) {
            
            NSArray *arr  = [PoliceBlackListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            
            for (PoliceBlackListModel *model in arr) {
                
                [MyCoreDataManager selectDataWith_CoredatamoldeClass:[AllPoliceBlack class] where:[NSString stringWithFormat:@"pbl_id = '%@'",model.pbl_id] Alldata_arr:^(NSArray *coredataModelArr) {
                    
                    if (!(coredataModelArr.count > 0)) {
                        
                        [MyCoreDataManager inserDataWith_CoredatamodelClass:[AllPoliceBlack class] CoredataModel:^(AllPoliceBlack *info) {
                            
                            info.pbl_id = model.pbl_id;
                            info.name = model.name;
                            info.id_card = model.id_card;
                            info.note = model.note;
                            
                        } Error:^(NSError *error) {
                            
                        }];
                    }
                } Error:^(NSError *error) {
                    
                }];
            }
            success();
        }else{
            
            failure(error);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}
@end
