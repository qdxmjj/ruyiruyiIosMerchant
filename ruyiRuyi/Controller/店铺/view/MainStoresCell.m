//
//  MainStoresCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/24.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MainStoresCell.h"
#import <UIImageView+WebCache.h>
#import "JJTools.h"
@implementation MainStoresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.accessoryType=UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;


}

-(void)setModel:(StoresModel *)model{
    
    [self.storeOrdersImg sd_setImageWithURL:[NSURL URLWithString:model.orderImage]];
    
    self.storeOrdersTitleLab.text = model.orderName;
    
    self.storeOrdersDateLab.text =[JJTools getTimestampFromTime:model.orderTime];
    
    self.storeOrdersPriceLab.text = [NSString stringWithFormat:@"+%@",model.orderPrice];
    
    NSString *status = [model.orderType longLongValue] == 1?@"交易完成":[model.orderType longLongValue] == 2?@"待收货":[model.orderType longLongValue] == 3?@"待商家确认服务":[model.orderType longLongValue] == 4?@"作废":[model.orderType longLongValue] == 5?@"待发货":[model.orderType longLongValue] == 6?@"待车主确认服务":[model.orderType longLongValue] == 7?@"待评价":@"待支付";
    
    self.storeOrdersStatusLab.text = status;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
