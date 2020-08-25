//
//  OrderManageCell.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderManageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIView *statusBGView;

@property (nonatomic, strong)StockOrderListModel *model;
@end

NS_ASSUME_NONNULL_END
