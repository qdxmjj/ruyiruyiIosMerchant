//
//  OrderFactory.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrderFactory.h"

@implementation OrderFactory

+(OrderDetailsViewController *)GenerateOrders:(orderType)orderType orderStatus:(orderState)status{

    OrderDetailsViewController *produceOrder;
    
    switch (orderType) {
        case OrderOrdinaryCommodityType:{
            
            produceOrder = [[StoresOrderViewController alloc] initWithOrdersStatus:status];

        }
            break;
        case OrderFreeChangeAgainType:{
            
            produceOrder = [[FreeChangeAgainViewController alloc] initWithOrdersStatus:status];
        }
            break;
            
        case OrderFirstReplaceType:{
            
            produceOrder = [[FirstReplaceOrderViewController alloc] initWithOrdersStatus:status];

        }
            break;
        case OrderTireRepairType:{
            
            produceOrder = [[TireRepairViewController alloc] initWithOrdersStatus:status];

        }
            break;
            
        default:
            break;
    }
    
    return produceOrder;
}

@end
