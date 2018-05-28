//
//  MyServiceTableViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ServiceRequest.h"

@interface MyServiceTableViewController : BaseTableViewController

-(instancetype)initWithServiceType:(ServiceTypeList )listType;

-(void)getServiceList;


-(NSArray *)selectDataArr;


@end
