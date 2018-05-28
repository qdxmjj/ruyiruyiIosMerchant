//
//  SellingCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/14.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "SellingCell.h"
#import <UIImageView+WebCache.h>
@implementation SellingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setValueWithModel:(sellingModel *)model{
    
    self.titleLab.text = model.name;
    self.soldLab.text = [model.soldNo stringValue];
    self.priceLab.text = [model.price stringValue];
    self.stocklab.text = [model.amount stringValue];
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
