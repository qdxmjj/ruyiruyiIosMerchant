//
//  FirstReplaceOrderModel.h
//  ruyiRuyi
//
//  Created by yym on 2020/7/14.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseModel.h"
#import "FirstReplaceMapModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstReplaceOrderModel : BaseModel

@property (nonatomic, strong) NSArray *mapList;
@property (nonatomic, assign) BOOL boolean;
@property (nonatomic, strong) NSDictionary *orderDTO;

@end

NS_ASSUME_NONNULL_END
