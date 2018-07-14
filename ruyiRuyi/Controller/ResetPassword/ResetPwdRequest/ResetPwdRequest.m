//
//  ResetPwdRequest.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ResetPwdRequest.h"

@implementation ResetPwdRequest


+(void)changeStorePwdWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler{
    
    
    [self postRequest:@"changeStorePwd" params:@{@"reqJson":[JJTools convertToJsonData:info]} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        

        succrsshandler(code,message,data);
        [MBProgressHUD showTextMessage:message];
        
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
    
}
@end
