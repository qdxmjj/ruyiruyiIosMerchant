//
//  StockOrderGoodsCell.h
//  ruyiRuyi
//
//  Created by yym on 2020/5/25.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockOrderGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^addStockBlock)(StockOrderGoodsModel *model);
typedef void(^deleteStockBlock)(StockOrderGoodsModel *model);
typedef void (^editNumberBlock)(NSString *number);
@interface StockOrderGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;
@property (weak, nonatomic) IBOutlet UILabel *leibieLab;
@property (weak, nonatomic) IBOutlet UILabel *huawenLab;
@property (weak, nonatomic) IBOutlet UILabel *danjiaLab;
@property (weak, nonatomic) IBOutlet UITextField *shuliangTextField;
@property (weak, nonatomic) IBOutlet UILabel *jineLab;
@property (weak, nonatomic) IBOutlet UIButton *caozuoBtn;

@property (copy, nonatomic) addStockBlock addBlock;
@property (copy, nonatomic) deleteStockBlock deleteBlock;
@property (nonatomic, strong) editNumberBlock editBlock;

@property (nonatomic, strong) StockOrderGoodsModel *model;

@end

NS_ASSUME_NONNULL_END
