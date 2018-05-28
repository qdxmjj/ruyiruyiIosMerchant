//
//  StoresRequest.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/25.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJRequest.h"
@interface StoresRequest : JJRequest


+(void)updateStoreHeadImgByStoreIdWithInfo:(NSDictionary *)info headPhoto:(NSArray <JJFileParam *>*)headPhoto succrss:(_Nullable requestSuccessBlock )succrsshandler failure:(_Nullable requestFailureBlock)failureHandler;

@end
