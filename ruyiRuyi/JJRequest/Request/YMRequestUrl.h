//
//  YMRequestUrl.h
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#ifndef YMRequestUrl_h
#define YMRequestUrl_h

///HTTPS url
#define YMBaseUrl @"http://180.76.243.205:2020/"

///获取 库管订单列表
#define kStockOrderList @"order/orderList"

///获取微信支付配置信息
#define kGetWeixinPaySign @"weixin/getWeixinPaySign"

///获取保证金信息
#define kGetBond @"Cash/getCash"

///生成订单
#define kCreateOrder @"order/createOrder"

///生成订单号
#define kCashDepos @"Cash/CashDepos"

///确认订单 已废弃
#define kConfirmOrder @"/order/confirm"
///扫码确认收货 新增
#define kConfirmBarcode @"order/confirmBarcode"

///获取支付宝微信订单签名
#define kGetAliPaySign @"Aliyun/getAliPaySign"
#define kGetWeixinPaySign @"weixin/getWeixinPaySign"

///获取库存订单列表  userId
#define kGetStockOrderList @"orderServe/userorder"

///获取库存列表 userId=1&page=1&pageSize=10&size=R16  size搜索
#define kGetAllGoods @"user/findGoods"

#endif /* YMRequestUrl_h */
