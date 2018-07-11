//
//  FreeChangeAgainViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrderDetailsViewController.h"

@interface FreeChangeAgainViewController : OrderDetailsViewController

/**
 * 默认初始化方法
 */
-(instancetype)initWithOrdersStatus:(orderState)orderState;


@property(nonatomic,copy)popOrdersVCBlock popOrdersVCBlock;

-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId;

@end
