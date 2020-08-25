//
//  StockManageModel.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StockManageModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *creatDate;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *figure;
@property (nonatomic, copy) NSString *spec;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *barCode;
@property (nonatomic, copy) NSString *goodsClassId;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *num;


@end

NS_ASSUME_NONNULL_END
