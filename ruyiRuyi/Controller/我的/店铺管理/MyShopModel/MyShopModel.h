//
//  MyShopModel.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyShopModel : NSObject

@property(nonatomic,copy)NSString *storeName;//门店名

@property(nonatomic,copy)NSString *storeType;//门店类型

@property(nonatomic,copy)NSString *storeTEL;//TEL

@property(nonatomic,copy)NSString *storeTime;//商店营业时间

@property(nonatomic,copy)NSString *storeStartTime;//开始时间

@property(nonatomic,copy)NSString *storeEndTime;//结束时间

@property(nonatomic,copy)NSString *storeAddress;//详细地址

@property(nonatomic,copy)NSString *storeLocation;//所在城市位置

@property(nonatomic,strong)NSURL *factoryImgUrl;//

@property(nonatomic,strong)NSURL *indoorImgUrl;

@property(nonatomic,strong)NSURL *locationImgUrl;

@property(nonatomic,strong)NSArray *storeServcieList;//服务列表

@property(nonatomic,assign)BOOL isBusiness;//是否营业







@end
