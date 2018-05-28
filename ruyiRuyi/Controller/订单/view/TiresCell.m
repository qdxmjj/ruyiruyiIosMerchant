//
//  TiresCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "TiresCell.h"
#import <UIImageView+WebCache.h>
@implementation TiresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)setTiresModel:(TiresModel *)model orderType:(NSString *)orderType{
    
    self.shoeNameLab.text = model.shoeName;
    
    NSString *fontRear = [model.fontRearFlag longLongValue] == 0 ?@"前胎/后胎":[model.fontRearFlag longLongValue] == 1?@"前胎":@"后胎";
    
    NSString *orderTypeS = [orderType longLongValue] == 1?@"普通商品购买":[orderType longLongValue] == 2?@"首次更换":[orderType longLongValue] == 3?@"免费再换":@"轮胎修补";
    
    self.fontRearFlagLab.text = [NSString stringWithFormat:@"更换位置：%@",fontRear];
    
    self.fontAmountLab.text = [NSString stringWithFormat:@"更换数量：%@",model.fontAmount];
    
    self.orderTypeLab.text = [NSString stringWithFormat:@"服务项目：%@",orderTypeS];
    
    [self.shoeImgView sd_setImageWithURL:[NSURL URLWithString:model.shoeImg]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
