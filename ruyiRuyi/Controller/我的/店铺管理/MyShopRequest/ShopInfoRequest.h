//
//  ShopInfoRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"

@interface ShopInfoRequest : JJRequest




+(void)getShopInfoWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

+(void)getCommitByConditionWithInfo:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

+(void)updateStoreInfoWithInfo:(NSDictionary *)info serviceTypes:(NSString *)serviceType photos:(NSArray <JJFileParam *> *)photos succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

@end
