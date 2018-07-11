//
//  FirstReplaceOrdersViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrderDetailsViewController.h"


@interface FirstReplaceOrdersViewController : OrderDetailsViewController


-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId;

/**
 * 默认初始化方法
 */
-(instancetype)initWithOrdersStatus:(orderState )orderState;


@property(nonatomic,copy)popOrdersVCBlock popOrdersVCBlock;

@end
