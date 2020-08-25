//
//  OrderManageCell.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "OrderManageCell.h"

@implementation OrderManageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(StockOrderListModel *)model{
    _model = model;
    
    self.label1.text = [NSString stringWithFormat:@"店铺名称：%@",model.userName];
    self.label2.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    self.label3.text = [NSString stringWithFormat:@"下单时间：%@",model.createTime];
    
    NSInteger status = [model.status integerValue];
    NSString *statusString = @"";
    switch (status) {
        case -1:
            statusString = @"审核未通过";
            break;
        case 0:
            statusString = @"待审核";
            break;
        case 1:
            statusString = @"审核完成,未发货";
            break;
        case 2:
            statusString = @"已发货,未确认";
            
            break;
        case 3:
            statusString = @"确认收货，交易成功";
            break;
        case 4:
            break;
        case 5:
//            statusString = @"交易取消";
            break;
        case 6:
//            statusString = @"交易结束";
            break;
        default:
            break;
    }
    self.statusLab.text = statusString;
    
    self.statusBGView.layer.masksToBounds = YES;
    self.statusBGView.layer.cornerRadius = CGRectGetHeight(self.statusBGView.frame)/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
