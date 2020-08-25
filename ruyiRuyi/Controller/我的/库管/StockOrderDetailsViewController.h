//
//  StockOrderDetailsViewController.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseViewController.h"
#import "StockOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^refreshBlock) (void);
@interface StockOrderDetailsViewController : BaseViewController

@property (nonatomic, strong)StockOrderListModel *model;

@property (nonatomic, copy) refreshBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
