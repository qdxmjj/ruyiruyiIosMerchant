//
//  MyOrderTableViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MyOrdersRequeset.h"
@interface MyOrderTableViewController : BaseTableViewController


-(instancetype)initWithServiceType:(MyOrdersTypeList )listType;

-(void)getMyOrdersInfo:(NSString *)number;


@end
