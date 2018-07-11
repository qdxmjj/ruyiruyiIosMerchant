//
//  MainOrdersRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/22.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"

typedef NS_ENUM(NSInteger,StoreServiceType) {
    
    StoreConfirmServiceType = 1,//确认服务
    clientSelfHelpServiceType,//补差服务，客户自提
    StoreRefuseServiceType,//拒绝服务
};


@interface MainOrdersRequest : JJRequest

//主页订单与店铺订单列表  type: 1:商品订单 2:如意如意平台订单）
+(void)getStoreGeneralOrderByTypeWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

+(void)getStoreOrderInfoByNoAndTypeWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//已完成&&未完成订单列表
+(void)getStoreGeneralOrderByTypeAndStateWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//待收货 确定提交
+(void)submitStoreConfirmReceiptShoesWithInfo:(NSArray *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//首次更换   商家确认服务，客户自提，拒绝服务 首次更换
+(void)confirmServrceTypeWithInfo:(NSDictionary *)info photos:(NSArray <JJFileParam *> *)photos succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//免费再换
+(void)freeChangeServiceTypeWithInfo:(NSDictionary *)info changeBarCodeVoList:(NSArray *)BarCodeList photos:(NSArray <JJFileParam *> *)photos succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//免费修补
+(void)tireRepairSelectServiceTypeWithInfo:(NSDictionary *)info repairBarCodeList:(NSArray *)repairbarCodeLish photos:(NSArray <JJFileParam *> *)photos succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

@end
