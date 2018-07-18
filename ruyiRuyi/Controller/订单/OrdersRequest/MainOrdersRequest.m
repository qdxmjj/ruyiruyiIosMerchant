//
//  MainOrdersRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/22.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MainOrdersRequest.h"

@implementation MainOrdersRequest

+(void)getStoreGeneralOrderByTypeWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"getStoreGeneralOrderByType" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

    } failure:^(NSError * _Nullable error) {
        
    }];
}

+(void)getStoreOrderInfoByNoAndTypeWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"getStoreOrderInfoByNoAndType" params:@{@"reqJson":[JJTools convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
    
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

        
    } failure:^(NSError * _Nullable error) {
        
        failureHandler(error);
    }];
}

+(void)getStoreGeneralOrderByTypeAndStateWithInfo:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"getStoreGeneralOrderByTypeAndState" params:@{@"reqJson":[JJTools convertToJsonData:info],@"token":[UserConfig token]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        succrsshandler(code,message,data);

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

+(void)confirmServrceTypeWithInfo:(NSDictionary *)info photos:(NSArray <JJFileParam *> *)photos succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self updateRequest:@"storeSelectFirstChangeShoeOrderType" params:@{@"reqJson":[JJTools convertToJsonData:info],@"token":[UserConfig token]} fileConfig:photos progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            succrsshandler(code,message,data);
        }
        
        [MBProgressHUD showTextMessage:message];
        
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
    }];
}

+(void)freeChangeServiceTypeWithInfo:(NSDictionary *)info changeBarCodeVoList:(NSArray *)BarCodeList photos:(NSArray<JJFileParam *> *)photos succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    
    [JJRequest updateRequest:@"storeSelectChangeShoeOrderType" params:@{@"reqJson":[JJTools convertToJsonData:info],@"changeBarCodeVoList":[JJTools convertToJsonData:BarCodeList],@"token":[UserConfig token]} fileConfig:photos progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        
        //进度
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue]==1) {
            

            succrsshandler(code,message,data);
        }else{
            
            NSLog(@"%@          %@",code,message);
        }
        
        [MBProgressHUD showTextMessage:message];
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
    }];
}

+(void)tireRepairSelectServiceTypeWithInfo:(NSDictionary *)info repairBarCodeList:(NSArray *)repairbarCodeLish photos:(NSArray<JJFileParam *> *)photos succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self updateRequest:@"storeSelectShoeRepairOrderType" params:@{@"reqJson":[JJTools convertToJsonData:info],@"repairBarCodeList":[JJTools convertToJsonData:repairbarCodeLish],@"token":[UserConfig token]} fileConfig:photos progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        //进度
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
        if ([code longLongValue]==1) {
            
            
            succrsshandler(code,message,data);
        }else{
            
            NSLog(@"%@          %@",code,message);
        }
        
        [MBProgressHUD showTextMessage:message];
        
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
    }];
    
    
    
}
@end
