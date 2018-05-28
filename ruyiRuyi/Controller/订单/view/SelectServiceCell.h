//
//  SelectServiceCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainOrdersRequest.h"

typedef void (^popViewBlock)(BOOL isPop);

@interface SelectServiceCell : UITableViewCell


@property(nonatomic,copy)NSString *ordersNum;

@property(nonatomic,copy)NSString *orderType;

-(void)setCellType:(StoreServiceType )serviceType;

@property(nonatomic,copy)popViewBlock popBlock;
@end
