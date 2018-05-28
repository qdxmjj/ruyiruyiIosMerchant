//
//  ServiceRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"
//我的订单
typedef enum : NSUInteger{
    
    ServiceTypeBaoyang = 2,//保养
    ServiceTypeMeirong = 3,//美容清洗
    ServiceTypeAnzhuang = 4,//安装
    ServiceTypeGaizhuang = 5,//改装
    
} ServiceTypeList;


@interface ServiceRequest : JJRequest

+(void)getStoreServiceSubClassWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;


+(void)addStoreServicesSubClassWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;
@end
