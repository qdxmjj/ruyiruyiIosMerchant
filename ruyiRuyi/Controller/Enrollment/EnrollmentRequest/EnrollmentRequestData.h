//
//  EnrollmentRequestData.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"
@interface EnrollmentRequestData : JJRequest

//获取验证码
+(void)getCodeWithReqJson:(NSString *)phone succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//获取门店类别

+(void)getStoreTypeWithSuccrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;
//获取城市列表

+(void)getCityListWithJson:(NSString *)reqJson succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;
//获取服务项目

+(void)getStoreServiceTypeWithSuccrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;


+(void)userEnrollmentWithReqjson:(NSString *)reqJson serviceTypes:(NSString *)serviceTypeList photos:(NSArray <JJFileParam *> *)photos succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;



@end
