//
//  AdditionalIncomeModel.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/15.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeModel.h"

@interface AdditionalIncomeModel : IncomeModel
@property(nonatomic,copy)NSString *appInstall;
@property(nonatomic,copy)NSString *createdTime;
@property(nonatomic,copy)NSString *earnings;
@property(nonatomic,copy)NSString *additionalIncomeID;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *storeId;
@property(nonatomic,copy)NSString *storeName;

@end
