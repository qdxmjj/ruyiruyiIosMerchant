//
//  DeliveryOrderModel.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliveryOrderModel : NSObject


@property(nonatomic,copy)NSString *no;//订单号
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *orderTypeName;
@property(nonatomic,copy)NSString *lastUpdatedTime;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;//电话号码
@property(nonatomic,copy)NSString *platNumber;//车牌号
@property(nonatomic,copy)NSString *receivingAddressId;
@property(nonatomic,copy)NSString *shippingAddressId;
@property(nonatomic,copy)NSString *storeAddress;
@property(nonatomic,copy)NSString *storeName;
@property(nonatomic,copy)NSString *storePhone;//
@property(nonatomic,copy)NSString *orderID;//

@property(nonatomic,copy)NSString *userId;//ID
@property(nonatomic,copy)NSString *time;//日期

@property(nonatomic,strong)id      tireList;

@property(nonatomic,copy)NSString *frontTyre;//前轮数量
@property(nonatomic,copy)NSString *rearTyre;//后轮数量

@property(nonatomic,copy)NSString *frontTyreId;//前轮轮胎ID
@property(nonatomic,copy)NSString *rearTyreId;//后轮轮胎ID

@property(nonatomic,copy)NSString *frontTyreName;//标题
@property(nonatomic,copy)NSString *rearTyreName;//标题

@property(nonatomic,copy)NSString *frontOrderImg;//IMG
@property(nonatomic,copy)NSString *rearOrderImg;//IMG

@property(nonatomic,strong)NSNumber *frontTyrePrice;//价格
@property(nonatomic,copy)NSString *rearTyrePrice;//价格

@property(nonatomic,assign)BOOL isConsistent;//前后轮是否一致

@end
