//
//  StoresOrderCommodityCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/22.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "StoresOrderCommodityCell.h"
#import <UIImageView+WebCache.h>
@interface StoresOrderCommodityCell()

@property (weak, nonatomic) IBOutlet UIImageView *commodityImg;
@property (weak, nonatomic) IBOutlet UILabel *commodityName;

@property (weak, nonatomic) IBOutlet UILabel *commodityPrice;
@property (weak, nonatomic) IBOutlet UILabel *commodityNumber;

@end

@implementation StoresOrderCommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCommodityInfoModel:(CommodityInfoModel *)model{
    
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:model.detailImage] placeholderImage:[UIImage imageNamed:@"ic_my_shibai"]];
    
    self.commodityName.text = model.detailName;
    self.commodityPrice.text = model.detailPrice;
    self.commodityNumber.text = [NSString stringWithFormat:@"%@",model.amount];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
