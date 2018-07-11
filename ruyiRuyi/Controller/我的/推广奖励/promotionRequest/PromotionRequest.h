//
//  PromotionRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"

@interface PromotionRequest : JJRequest

+(void)getPromotionAwardInfoWithReqjson:(NSDictionary *)info succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

@end
