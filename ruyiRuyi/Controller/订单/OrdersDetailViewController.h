//
//  OrdersDetailViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSInteger{
    
    ordersStateFulfill = 1,
    ordersStateWaitReceipt,
    ordersStateWaitConfirm,
    ordersStateInvalid,
    ordersStateWaitShip,
    ordersStateWaitOwnerConfirmation,
    ordersStateWaitAssess,
    ordersStateWaitPay,
    
    
} orderState;

typedef void (^popOrdersVCBlock)(BOOL isPop);


@interface OrdersDetailViewController : BaseViewController


-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId;

-(instancetype)initWithOrdersStatus:(orderState )orderState;

@property(nonatomic,copy)popOrdersVCBlock popOrdersVCBlock;

@end
