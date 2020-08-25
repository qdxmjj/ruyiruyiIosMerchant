//
//  StockBuyCartViewController.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/26.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^cleanBlock) (void);

@interface StockBuyCartViewController : BaseViewController

@property (strong, nonatomic) NSMutableArray *goodsDataArray;

@property (copy, nonatomic) cleanBlock cleanBlock;
@end

NS_ASSUME_NONNULL_END
