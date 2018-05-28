//
//  OrderCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrderCell.h"
#import <UIImageView+WebCache.h>
@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setModel:(OrdersModel *)model{
    
    [self.orderImg sd_setImageWithURL:[NSURL URLWithString:model.orderImage]];
    self.ordersType.text = model.orderName;
    self.carNumber.text = model.platNumber;
    self.statusImg.hidden = [model.isRead longLongValue] == 1 ? YES:NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
