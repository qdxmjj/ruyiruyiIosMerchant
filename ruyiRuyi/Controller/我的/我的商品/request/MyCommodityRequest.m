//
//  MyCommodityRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyCommodityRequest.h"

@implementation MyCommodityRequest

+(void)getStoreAddedServicesWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"getStoreAddedServices" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ([code longLongValue] != 1) {
            

            [MBProgressHUD showTextMessage:message];
            return ;
        }
        
        NSArray *keyArr =[data allKeys];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        if ([keyArr containsObject:@"美容清洗"]) {
            
            [dic setObject:[data objectForKey:@"美容清洗"] forKey:@"美容清洗"];
            
        }
        if ([keyArr containsObject:@"汽车保养"]){
            [dic setObject:[data objectForKey:@"汽车保养"] forKey:@"汽车保养"];
            
            
        }
        if ([keyArr containsObject:@"安装改装"]){
            [dic setObject:[data objectForKey:@"安装改装"] forKey:@"安装改装"];
            
        }
        if([keyArr containsObject:@"轮胎服务"]){
            
            [dic setObject:[data objectForKey:@"轮胎服务"] forKey:@"轮胎服务"];
        }
        
        succrsshandler(code,message,dic);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

+(void)addCommodityWithInfo:(NSDictionary *)info hotos:(NSArray<JJFileParam *> *)photos succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self updateRequest:@"addStock" params:@{@"reqJson":[JJTools convertToJsonData:info]} fileConfig:photos progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
   
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
    }];
}

+(void)getStockByConditionWithIno:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"getStockByCondition" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

    } failure:^(NSError * _Nullable error) {
        
    }];
}

+(void)updateStockTypeWithInfo:(NSDictionary *)info stock_img:(NSArray<JJFileParam *> *)stock_img succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self updateRequest:@"updateStock" params:@{@"reqJson":[JJTools convertToJsonData:info]} fileConfig:stock_img progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
    }];
    
}
@end
