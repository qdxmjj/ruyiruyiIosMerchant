//
//  LogInrequestData.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "LogInrequestData.h"

@implementation LogInrequestData

+(void)logInRequestWithReqJson:(NSString *)reqJson succrss:(requestSuccessBlock)succrsshandler failure:(requestFailureBlock)failureHandler{
    
    [JJRequest postRequest:@"storePwdLogin" params:@{@"reqJson":reqJson} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        
        
        [MBProgressHUD showTextMessage:message];
        succrsshandler(code,message,data);
    } failure:^(NSError * _Nullable error) {
        
        
        
    }];
}



@end
