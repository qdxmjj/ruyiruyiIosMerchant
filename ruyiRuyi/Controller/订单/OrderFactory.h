//
//  OrderFactory.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailsViewController.h"
#import "FreeChangeAgainViewController.h"
#import "FirstReplaceOrdersViewController.h"
#import "TireRepairViewController.h"
#import "StoresOrderViewController.h"
typedef NS_ENUM(NSInteger,orderType) {
    
    OrderOrdinaryCommodityType = 1,//普通商品订单
    OrderFirstReplaceType = 2,//首次更换订单
    OrderFreeChangeAgainType = 3,//免费再换订单
    OrderTireRepairType = 4,//轮胎修补订单
    
};

@interface OrderFactory : NSObject

+(OrderDetailsViewController *)GenerateOrders:(orderType)orderType orderStatus:(orderState)status;


@end
