//
//  MyOrdersDetailsController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MyOrdersDetailsController : BaseTableViewController

-(void)getMyOrdersDetailsInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId;
@end
