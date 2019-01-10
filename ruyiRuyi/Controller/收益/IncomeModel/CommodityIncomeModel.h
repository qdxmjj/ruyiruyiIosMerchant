//
//  CommodityIncomeModel.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/15.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeModel.h"

@interface CommodityIncomeModel : IncomeModel

@property(nonatomic,copy)NSString *commissions;
@property(nonatomic,copy)NSString *createdBy;
@property(nonatomic,copy)NSString *createdTime;
@property(nonatomic,copy)NSString *ndeletedByo;
@property(nonatomic,copy)NSString *deletedFlag;
@property(nonatomic,copy)NSString *discountFlag;
@property(nonatomic,copy)NSString *earnings;
@property(nonatomic,copy)NSString *earningsType;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *orderType;
@property(nonatomic,copy)NSString *storeId;
@property(nonatomic,copy)NSString *totalCommissions;


@end
