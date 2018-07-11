//
//  OrderDetailsViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"
#import "MainOrdersRequest.h"
#import "OrdersInfoCell.h"
#import "TiresCell.h"
#import "OrdersPhotoCell.h"
#import "SelectServiceCell.h"
#import "CodeNumberCell.h"
#import "CodeNumheadView.h"

typedef enum : NSInteger{

    ordersStateFulfill = 1,//交易完成
    ordersStateWaitReceipt,//待收货
    ordersStateWaitConfirm,//待商家确认服务
    ordersStateInvalid,//作废
    ordersStateWaitShip,//待发货
    ordersStateWaitOwnerConfirmation,//待车主确认服务
    ordersStateWaitAssess,//待评价
    ordersStateWaitPay,//待支付
    ordersStatuRefunding,//退款中
    ordersStatusRefunded,//已退款
    ordersStateRefuseService = 14,//拒绝服务 -- 已取消
    ordersStateUserCanceled = 15 ,//用户已取消 
    
} orderState;

typedef void (^popOrdersVCBlock)(BOOL isPop);

@interface OrderDetailsViewController : BaseViewController

/**
 * 请求订单页面数据
 */
-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId;

/**
 * 确认订单等选项完成后的回调
 */
@property(nonatomic,copy)popOrdersVCBlock popOrdersVCBlock;


@end
