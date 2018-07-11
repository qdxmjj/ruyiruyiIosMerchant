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
    
    if ([model.orderState isEqualToString:@"14"]) {
        
        if ([model.orderType isEqualToString:@"4"]) {
            
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ic_hui_xiubu" ofType:@"png"];
            self.orderImg.image = [UIImage imageWithContentsOfFile:imagePath];
            
        }else if ([model.orderType isEqualToString:@"2"]){
            
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ic_shouci" ofType:@"png"];
            self.orderImg.image = [UIImage imageWithContentsOfFile:imagePath];
            
        }else{
            
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ic_hui_free" ofType:@"png"];
            self.orderImg.image = [UIImage imageWithContentsOfFile:imagePath];
        }
    }else{
        [self.orderImg sd_setImageWithURL:[NSURL URLWithString:model.orderImage]];
    }
    self.ordersType.text = model.orderName;
    self.carNumber.text = model.platNumber;
    self.statusImg.hidden = [model.isRead longLongValue] == 1 ? YES:NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
