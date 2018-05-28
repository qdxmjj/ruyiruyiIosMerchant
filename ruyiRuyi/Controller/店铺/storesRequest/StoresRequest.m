//
//  StoresRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/25.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "StoresRequest.h"

@implementation StoresRequest

+(void)updateStoreHeadImgByStoreIdWithInfo:(NSDictionary *)info headPhoto:(NSArray<JJFileParam *> *)headPhoto succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self updateRequest:@"updateStoreHeadImgByStoreId" params:@{@"reqJson":[JJTools convertToJsonData:info],@"token":[UserConfig token]} fileConfig:headPhoto progress:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
    } success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue]==1) {
            
            succrsshandler(code,message,data);
        }
        
        [MBProgressHUD showTextMessage:message];
    } complete:^(id  _Nullable dataObj, NSError * _Nullable error) {
        
    }];
    
}



@end
