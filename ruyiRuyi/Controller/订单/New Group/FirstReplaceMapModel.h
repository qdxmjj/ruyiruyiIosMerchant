//
//  FirstReplaceMapModel.h
//  ruyiRuyi
//
//  Created by yym on 2020/7/14.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstReplaceMapModel : BaseModel

@property (nonatomic, copy) NSString *font_rear_flag;
@property (nonatomic, copy) NSString *font_shoe_id;
@property (nonatomic, copy) NSString *font_price;
@property (nonatomic, copy) NSString *font_amount;
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *rear_amount;
@property (nonatomic, copy) NSString *rear_price;
@property (nonatomic, copy) NSString *rear_total_price;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *total_cxwy_no;
@property (nonatomic, copy) NSString *total_price;
@property (nonatomic, copy) NSString *total_shoe_no;
@property (nonatomic, copy) NSString *trade_mode;
@property (nonatomic, copy) NSString *user_car_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *order_no;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *plat_number;

@property (nonatomic, copy) NSString *rear_shoe_id;///缺少此字段

@end

NS_ASSUME_NONNULL_END
