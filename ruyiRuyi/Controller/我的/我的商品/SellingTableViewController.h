//
//  SellingTableViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/14.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CommodityTypeModel.h"
#import "MyCommodityRequest.h"

@interface SellingTableViewController : BaseTableViewController


-(void)getStockByConditionWithPage:(NSString *)page serviceTypeId:(NSString *)serviceTypeId servicesId:(NSString *)servicesId stockStatus:(NSString *)stockStatus;

//刷新数据
-(void)RefreshData;

//服务大类ID
@property(nonatomic,copy)NSString *serviceTypeId;
//服务对应的小类ID
@property(nonatomic,copy)NSString *servicesId;


//根据ID查询ID对应的服务文本，商品信息里面只有ID没有ID对应内容，需要自己查
@property(nonatomic,strong)CommodityTypeModel *cModel;

//初始化方法
-(instancetype)initWithServiceType:(CommodityType )listType;


@end
