//
//  StockManageSearchController.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BaseViewController.h"
#import "YMRequest.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^serachBlock) (NSString *searchContent);
@interface StockManageSearchController : BaseViewController

@property (nonatomic, copy) NSString *searchContent;

@property (nonatomic, copy) serachBlock searchBlock;
@end

NS_ASSUME_NONNULL_END
