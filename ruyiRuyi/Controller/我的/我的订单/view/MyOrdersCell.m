//
//  MyOrdersCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/21.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyOrdersCell.h"
#import <UIImageView+WebCache.h>
#import "JJMacro.h"
@implementation MyOrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.Voucher.layer.borderColor = [JJThemeColor CGColor];
    self.Voucher.layer.borderWidth = 1.f;
}

-(void)setModel:(MyOrdersDetailsModel *)model{
    
    NSString *orderTypeS = [model.orderState longLongValue] == 1?@"已完成":[model.orderState longLongValue] == 2?@"确认收货":[model.orderState longLongValue] == 3?@"确认服务":[model.orderState longLongValue] == 4?@"作废":[model.orderState longLongValue] == 5?@"待发货":[model.orderState longLongValue] == 6?@"待车主确认服务":[model.orderState longLongValue] == 7?@"待评价":[model.orderState longLongValue] == 8?@"待支付":[model.orderState longLongValue] == 9?@"退款中":[model.orderState longLongValue] == 10?@"已退款":[model.orderState longLongValue] == 15?@"用户已取消":@"状态异常";
    
    self.ordersName.text = model.orderName;
    
    self.ordersNumber.text = [NSString stringWithFormat:@"订单编号：%@" ,model.orderNo];
    
    if([model.orderPrice longLongValue] != [model.orderActuallyPrice longLongValue]){
        
        self.Voucher.hidden = NO;
    }else{
        
        self.Voucher.hidden = YES;
    }
    
    self.ordersPrice.text = [NSString stringWithFormat:@"¥%@" ,model.orderPrice];

    self.ordersStatus.text = orderTypeS;
    
    [self.ordersImg sd_setImageWithURL:[NSURL URLWithString:model.orderImage]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
