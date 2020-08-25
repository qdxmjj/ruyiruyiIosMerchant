//
//  StockManageCell.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockManageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface StockManageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;
@property (weak, nonatomic) IBOutlet UILabel *leibieLab;
@property (weak, nonatomic) IBOutlet UILabel *huawenLab;
@property (weak, nonatomic) IBOutlet UILabel *tiaoxingmaLab;

@property (strong, nonatomic) StockManageModel *model;
@end

NS_ASSUME_NONNULL_END
