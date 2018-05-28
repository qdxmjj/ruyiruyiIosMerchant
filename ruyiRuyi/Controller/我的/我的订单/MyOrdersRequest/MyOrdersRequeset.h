//
//  MyOrdersRequeset.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/22.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"

typedef enum : NSInteger {
  
    ordersTypeAll = 0,              //全部
    ordersTypeTuBeDelivered,    //待发货
    ordersTypeWaitReceive,      //待收货
    ordersTypeWaitService,      //待服务
    ordersTypeCompleted,        //已完成

}MyOrdersTypeList;


@interface MyOrdersRequeset : JJRequest

+(void)getStoreGeneralOrderByStateWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;



@end
