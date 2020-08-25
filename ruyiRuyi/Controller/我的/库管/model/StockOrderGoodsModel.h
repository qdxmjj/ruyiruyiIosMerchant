//
//  StockOrderGoodsModel.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/25.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface StockOrderGoodsModel : BaseModel

@property (nonatomic, strong)NSString *flgureName;
@property (nonatomic, strong)NSString *minPrice;
@property (nonatomic, strong)NSString *price;//成本价
@property (nonatomic, strong)NSString *rate;
@property (nonatomic, strong)NSString *shoeId;
@property (nonatomic, strong)NSString *size;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *totalMoney;//售卖价格

///自定义增加字段 总价
@property (nonatomic, strong)NSString *totalPrice;//选择完数量*单价后的总价
@property (nonatomic, strong)NSString *stockNumber;//数量

@end

NS_ASSUME_NONNULL_END
