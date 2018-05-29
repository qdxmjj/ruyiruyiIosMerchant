//
//  MainOrdersRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/22.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MainOrdersRequest.h"

@implementation MainOrdersRequest

//主页订单与店铺订单列表  type: 1:商品订单 2:如意如意平台订单）
+(void)getStoreGeneralOrderByTypeWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"getStoreGeneralOrderByType" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
        [MBProgressHUD showTextMessage:message];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

+(void)getStoreOrderInfoByNoAndTypeWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"getStoreOrderInfoByNoAndType" params:@{@"reqJson":[JJTools convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
    
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

+(void)submitStoreConfirmReceiptShoesWithInfo:(NSArray *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"storeConfirmReceiptShoes" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
        [MBProgressHUD showTextMessage:message];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

+(void)confirmServrceTypeWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"storeSelectChangeShoeOrderType" params:@{@"reqJson":[JJTools convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}
@end
