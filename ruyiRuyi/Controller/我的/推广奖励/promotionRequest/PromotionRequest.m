//
//  PromotionRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "PromotionRequest.h"

@implementation PromotionRequest

+(void)getPromotionAwardInfoWithReqjson:(NSDictionary *)info succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [self postRequest:@"preferentialInfo/getStoreShareInfo" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] != 1) {
            
            [MBProgressHUD showTextMessage:message];
            return ;
        }
        
        succrsshandler(code,message,data);
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
}

@end
