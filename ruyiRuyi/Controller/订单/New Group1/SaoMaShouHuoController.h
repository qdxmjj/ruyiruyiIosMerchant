//
//  SaoMaShouHuoController.h
//  ruyiRuyi
//
//  Created by yym on 2020/6/16.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SaoMaShouHuoController : BaseTableViewController

@property (nonatomic, assign) NSInteger goodsCount;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *total_fee;

@end

NS_ASSUME_NONNULL_END
