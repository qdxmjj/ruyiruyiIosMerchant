//
//  MyCommodityRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"

typedef enum : NSUInteger{
    CommodityTypeSell = 1,//出售中
    CommodityTypeDrop = 2,//下架
    CommodityTypeDel = 3,//删除商品

    
} CommodityType;



@interface MyCommodityRequest : JJRequest

//获取商家添加的服务小类
+(void)getStoreAddedServicesWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;


// 添加商品
+(void)addCommodityWithInfo:(NSDictionary *)info hotos:(NSArray <JJFileParam *> *)photos succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

//获取商品信息列表
+(void)getStockByConditionWithIno:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;


+(void)updateStockTypeWithInfo:(NSDictionary *)info stock_img:(NSArray<JJFileParam *> *)stock_img succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;
@end
