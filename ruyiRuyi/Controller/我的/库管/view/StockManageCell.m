//
//  StockManageCell.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "StockManageCell.h"

@implementation StockManageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(StockManageModel *)model{
    _model = model;
    
    self.guigeLab.text = [NSString stringWithFormat:@"%@",model.size];
    self.leibieLab.text = [NSString stringWithFormat:@"%@",model.type];
    self.huawenLab.text = [NSString stringWithFormat:@"%@",model.figure];
    self.tiaoxingmaLab.text = [NSString stringWithFormat:@"%@",model.num];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
