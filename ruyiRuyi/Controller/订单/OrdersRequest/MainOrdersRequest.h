//
//  MainOrdersRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/22.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"

typedef NS_ENUM(NSInteger,StoreServiceType) {
    
    StoreConfirmServiceType,
    StoreRefuseServiceType,
    clientSelfHelpServiceType,
    
};


@interface MainOrdersRequest : JJRequest

+(void)getStoreGeneralOrderByTypeWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

+(void)getStoreOrderInfoByNoAndTypeWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

+(void)submitStoreConfirmReceiptShoesWithInfo:(NSArray *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//商家确认服务，客户自提，拒绝服务
+(void)confirmServrceTypeWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

@end
