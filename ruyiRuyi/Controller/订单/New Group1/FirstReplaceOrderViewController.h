//
//  FirstReplaceOrderViewController.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/20.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "OrderDetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstReplaceOrderViewController : OrderDetailsViewController

/**
 * 默认初始化方法
 */
-(instancetype)initWithOrdersStatus:(orderState )orderState;

@property(nonatomic,copy)popOrdersVCBlock popOrdersVCBlock;

@end

NS_ASSUME_NONNULL_END
