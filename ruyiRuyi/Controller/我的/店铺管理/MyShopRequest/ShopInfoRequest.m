//
//  ShopInfoRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ShopInfoRequest.h"

@implementation ShopInfoRequest

+(void)getShopInfoWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"getStoreInfoByStoreId" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}


+(void)getCommitByConditionWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    
    [self postRequest:@"getCommitByCondition" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            
            succrsshandler(code,message,data);
        }
        
//        [MBProgressHUD showTextMessage:message];
    } failure:^(NSError * _Nullable error) {
        
    }];
}


+(void)updateStoreInfoWithInfo:(NSDictionary *)info serviceTypes:(NSString *)serviceType photos:(NSArray <JJFileParam *> *)photos succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler{
    
    
    [self updateRequest:@"updateStoreInfoByStoreId" params:@{@"reqJson":[JJTools convertToJsonData:info],@"serviceTypeList":serviceType} fileConfig:photos progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
        succrsshandler(code,message,data);

    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
        failureHandler(error);
    }];
    
}
@end
