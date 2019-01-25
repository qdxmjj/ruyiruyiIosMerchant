
//
//  AddCommodityCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AddCommodityCell.h"

@implementation AddCommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.addCommoditySwitch addTarget:self action:@selector(isSpecialPriceGoods:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)isSpecialPriceGoods:(UISwitch *)sender {
    
    if (sender.on) {
        
        if ([self.delegate respondsToSelector:@selector(addCommodityCell:isSpecialPriceGoods:)]) {
            
            [self.delegate addCommodityCell:self isSpecialPriceGoods:sender.on];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(addCommodityCell:isSpecialPriceGoods:)]) {
            
            [self.delegate addCommodityCell:self isSpecialPriceGoods:NO];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
