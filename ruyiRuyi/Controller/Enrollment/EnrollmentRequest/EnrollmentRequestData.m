//
//  EnrollmentRequestData.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "EnrollmentRequestData.h"

@implementation EnrollmentRequestData



+(void)getCodeWithReqJson:(NSString *)phone succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler{
    
    NSDictionary *dic =@{@"phone":phone};
    
    [JJRequest postRequest:@"sendMsg" params:@{@"reqJson":[JJTools convertToJsonData:dic]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        [MBProgressHUD showTextMessage:message];
    } failure:^(NSError * _Nullable error) {
        
    }];
}


+(void)getStoreTypeWithSuccrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler{

    [JJRequest postRequest:@"getStoreType" params:@{@"reqJson":@""} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
//        [MBProgressHUD showTextMessage:message];

        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


+(void)getCityListWithJson:(NSString *)reqJson succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler{

    [JJRequest postRequest:@"getAllPositon" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }

//        [MBProgressHUD showTextMessage:message];

    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


+(void)getStoreServiceTypeWithSuccrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [JJRequest postRequest:@"getStoreServiceType" params:@{@"reqJson":@""} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);
    } failure:^(NSError * _Nullable error) {
        
    }];
}


+(void)userEnrollmentWithReqjson:(NSString *)reqJson serviceTypes:(NSString *)serviceTypeList photos:(NSArray <JJFileParam *> *)photos succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [JJRequest updateRequest:@"registerStore" params:@{@"reqJson":reqJson,@"serviceTypeList":serviceTypeList} fileConfig:photos progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
           
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        succrsshandler(code,message,data);
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
        failureHandler(error);
    }];
}

@end
