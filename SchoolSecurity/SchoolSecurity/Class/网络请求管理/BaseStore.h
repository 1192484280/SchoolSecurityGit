//
//  BaseStore.h
//  SchoolSecurity
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserModel.h"
#import "ScanParameterModel.h"
#import "SGDJParameterModel.h"
#import "LFParametersModel.h"
#import "LFDetailModel.h"
#import "FKParameterModel.h"
#import "FKDetailMode.h"
#import "XGDetailModel.h"
#import "PersonParameterModel.h"
#import "ScanModel.h"
@interface BaseStore : NSObject

/**
 * 登陆
 */
- (void)LoginWithAccount:(NSString *)account andPassWord:(NSString *)passWord Sucess:(void(^)(LoginUserModel *model))sucess failure:(void(^)(NSError *error))failure;


/**
 * 获取部门列表
 */
- (void)getPartListWithSchoolId:(NSString *)school_id Success:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure;


/**
 * 获取受访人列表
 */
- (void)getCallerListWithSchoolId:(NSString *)school_id andOrgId:(NSString *)org_id ArrSuccess:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure;


/**
 * 核实身份信息
 */
- (void)confirmIdCardWithIdCard:(NSString *)id_card andVrId:(NSString *)vr_id andVisiterId:(NSString *)visiter_id andSchoolId:(NSString *)school_id andSecuriyyId:(NSString *)security_personnel_id Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 同意或拒绝放行
 */
- (void)ifLetGoWithParameterModel:(ScanParameterModel *)model Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 手工登记
 */
- (void)ifLetGoWithSGDJParameterModel:(SGDJParameterModel *)model Success:(void(^)())success Failure:(void(^)(NSError *error))failure;

/**
 * 扫描身份证登出
 */
- (void)smLoginoutWithIdCard:(NSString *)IdCard andSecurityId:(NSString *)securityId Success:(void(^)())success Failure:(void(^)(NSError *error))failure;

/**
 * 获取来访管理列表
 */
- (void)getLFManagerListWithParametersModel:(LFParametersModel *)paraModel Success:(void(^)(NSArray *arr, BOOL haveMore))success Failure:(void(^)(NSError *error))failure;


/**
 * 获取来访详情
 */
- (void)getLFDetailInfoWithVr_id:(NSString *)vr_id Success:(void(^)(LFDetailModel *model))success Failure:(void(^)(NSError *error))failure;


/**
 * 获取随行人员详细数组
 */
- (void)getOtherListArrWithVr_id:(NSString *)vr_id Success:(void(^)(NSArray *arr))success Failure:(void(^)(NSError *error))failure;


/**
 * 访客登出
 */
- (void)fkLoginOutWithVr_Id:(NSString *)vr_id andSchoolId:(NSString *)schoolId andSecurityId:(NSString *)securityId Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 获取公安黑名单列表
 */
- (void)getPoliceBlackListWithPage:(NSString *)page Succes:(void(^)(NSArray *arr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure;


/**
 * 获取学校黑名单列表
 */
- (void)getSchoolBlackListWithSchoolID:(NSString *)schoolId andPage:(NSString *)page Succes:(void(^)(NSArray *arr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure;


/**
 * 添加黑名单
 */
- (void)addBlackListWithSchoolId:(NSString *)school_id andIdCard:(NSString *)idCard andName:(NSString *)name andNote:(NSString *)note andType:(BlackListType)type Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 编辑黑名单
 */
- (void)editBlackListWithParameterId:(NSString  *)Id andSchoolId:(NSString *)school_id andName:(NSString *)name andIdCard:(NSString *)idCard andNote:(NSString *)note andType:(BlackListType)type Success:(void(^)())success Failure:(void(^)(NSError *error))failure;

/**
 * 删除黑名单
 */
- (void)deleteBlackListWithId:(NSString *)Id andType:(BlackListType)type Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 获取访客管理列表
 */
-(void)getFKManagerListArrWithParameter:(FKParameterModel *)model Success:(void(^)(NSArray *arr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure;

/**
 * 访客详情
 */
- (void)getDetailInfoWithVisitor_id:(NSString *)visitor_id Success:(void(^)(FKDetailMode *model))success Failure:(void(^)(NSError *error))failure;

/**
 * 巡更列表
 */
- (void)getXGLBWithSchoolId:(NSString *)schoolId andSecurityId:(NSString *)securityId andPage:(NSString *)page Success:(void(^)(NSArray *listArr,BOOL haveMore))success Failure:(void(^)(NSError *error))failure;

/**
 * 巡更详情
 */
- (void)getXGDetailWithP_id:(NSString *)p_id Success:(void(^)(XGDetailModel *model))success Failure:(void(^)(NSError *error))failure;


/**
 * 获取个人信息
 */
-(void)getPersonInfoWithSchoolId:(NSString *)school_id andSecurityId:(NSString *)securityId Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 保存个人信息
 */
- (void)changePersonInfoWithParameter:(PersonParameterModel *)parameter Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 开始巡更
 */
- (void)startXGWithSchoolId:(NSString *)school_id andSecurityId:(NSString *)security_id Success:(void(^)(NSString *p_id))success Failure:(void(^)(NSError *error))failure;


/**
 * 结束巡更
 */
- (void)endXGWithSchoolId:(NSString *)school_id andSecurityId:(NSString *)security_id andP_id:(NSString *)p_id andLine:(NSString *)line andDistance:(NSString *)distance Success:(void(^)())success Failure:(void(^)(NSError *error))failure;


/**
 * 添加巡更扫描点
 */
- (void)addXGPointWithPs_id:(NSString *)ps_id andSecurityId:(NSString *)securityId andP_id:(NSString *)p_id andNote:(NSString *)note Success:(void(^)())success Failure:(void(^)(NSError *error))failure;

/**
 * 获取全部学校黑名单
 */
- (void)getAllSchoolBlackListWithSchoolId:(NSString *)school_id Success:(void(^)())success Failure:(void(^)(NSError *error))failure;

/**
 * 获取全部公安黑名单
 */
- (void)getAllPoliceBlackListSuccess:(void(^)())success Failure:(void(^)(NSError *error))failure;

/**
 * 获取扫描登记信息（原二维码扫描信息）
 */
- (void)getInfoWithVr_id:(NSString *)vr_id Success:(void(^)(ScanModel *model))success Failure:(void(^)(NSError *error))failure;


@end
