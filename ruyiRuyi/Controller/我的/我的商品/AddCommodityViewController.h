//
//  AddCommodityViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityTypeModel.h"
@interface AddCommodityViewController : BaseViewController


@property(nonatomic,copy)NSString *statusID;//商品ID

@property(nonatomic,copy)NSString *imgUrl;//商品图片地址，用于修改商品图片替换掉

@property(nonatomic,copy)NSString *name;//商品名称

@property(nonatomic,strong)NSString *price;//单价

@property(nonatomic,copy)NSString *status;//商品状态

@property(nonatomic,strong)NSString *amount;//库存

@property(nonatomic,copy)NSString *commodityTypeText;//显示用的商品分类

@property(nonatomic,copy)NSString *ServicesId;//提交商品用的小类ID

@property(nonatomic,copy)NSString *ServiceTypeId;//提交商品大类ID

@property(nonatomic,copy)NSString *headerImg;//传入的商品详情头像

@property(nonatomic,strong)CommodityTypeModel *aModel;//

@property(nonatomic,copy)NSString *bButtonTitle;

@end
