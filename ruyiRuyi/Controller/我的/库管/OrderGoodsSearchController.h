//
//  OrderGoodsSearchController.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^serachBlock) (NSMutableDictionary *searchDic);

@interface OrderGoodsSearchController : BaseViewController

@property (nonatomic, strong) NSMutableDictionary *searchDic;

@property (nonatomic, copy) serachBlock searchBlock;

@end

NS_ASSUME_NONNULL_END
