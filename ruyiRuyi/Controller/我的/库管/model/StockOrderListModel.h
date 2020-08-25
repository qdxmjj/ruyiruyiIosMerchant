//
//  StockOrderListModel.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StockOrderListModel : BaseModel

@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *totalFee;
@property (nonatomic, copy) NSString *totalNum;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *createTime;

@end

NS_ASSUME_NONNULL_END
