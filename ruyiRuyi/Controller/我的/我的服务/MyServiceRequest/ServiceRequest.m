//
//  ServiceRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ServiceRequest.h"

@implementation ServiceRequest



+(void)getStoreServiceSubClassWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"getStoreServicesAndState" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

    } failure:^(NSError * _Nullable error) {
        
    }];
}


+(void)addStoreServicesSubClassWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"addStoreServices" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
