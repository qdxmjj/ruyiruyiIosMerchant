//
//  SellingCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/14.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "SellingCell.h"
#import <UIImageView+WebCache.h>
#import "JJMacro.h"
#import "JJTools.h"
@implementation SellingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.delBtn.layer.cornerRadius = 3;
    self.delBtn.layer.borderWidth = 1;
    self.delBtn.layer.borderColor = [JJThemeColor CGColor];//
    self.delBtn.layer.masksToBounds = YES;
}

-(void)setValueWithModel:(sellingModel *)model{
    
    self.titleLab.text = model.name;
    self.soldLab.text = [NSString stringWithFormat:@"库存：%@",model.amount];
    self.priceLab.attributedText = [JJTools priceWithRedString:[NSString stringWithFormat:@"%@",model.price]];
    self.stocklab.text = [NSString stringWithFormat:@"已售：   %@",model.soldNo];
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
