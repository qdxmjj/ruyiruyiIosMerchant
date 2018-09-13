//
//  NewConfirmServiceCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "NewConfirmServiceCell.h"
#import "JJMacro.h"
#import <UIImageView+WebCache.h>
#import "JJTools.h"
@implementation NewConfirmServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.deliveryBtn.layer.borderColor = JJThemeColor.CGColor;
    self.deliveryBtn.layer.borderWidth = 1.f;
    self.deliveryBtn.layer.cornerRadius = 5;
    self.deliveryBtn.layer.masksToBounds = true;
    
    self.deliveryBtn2.layer.borderColor = JJThemeColor.CGColor;
    self.deliveryBtn2.layer.borderWidth = 1.f;
    self.deliveryBtn2.layer.cornerRadius = 5;
    self.deliveryBtn2.layer.masksToBounds = true;
}

-(void)setModel:(DeliveryOrderModel *)model{
    
    self.orderNumberLab.text = [NSString stringWithFormat:@"订单编号：%@",model.no];
    self.dateLab.text = [NSString stringWithFormat:@"%@",[JJTools getTimestampFromTime:model.time formatter:nil]];
    self.carIDLab.text = [NSString stringWithFormat:@"车牌号：%@",model.platNumber];
    self.photoLab.text = [NSString stringWithFormat:@"电话号码：%@",model.phone];
    
    if (model.isConsistent || [model.frontTyre isEqualToString:@"0"] || [model.rearTyre isEqualToString:@"0"]) {
        
        //前后轮不一致 或者前。后轮 有一个为0 显示一个商品
        //前轮为0 显示后轮 后轮为0显示前轮
        //都用第一个商品视图来显示
        
        if ([model.frontTyre isEqualToString:@"0"]) {
            
            self.commodityNameLab.text = model.rearTyreName;
            [self.commodityPhotoView sd_setImageWithURL:[NSURL URLWithString:model.rearOrderImg]];
            self.commodityPriceLab.text = [NSString stringWithFormat:@"¥%@.0",model.rearTyrePrice];
        }else{
            
            self.commodityNameLab.text = model.frontTyreName;
            [self.commodityPhotoView sd_setImageWithURL:[NSURL URLWithString:model.frontOrderImg]];
            self.commodityPriceLab.text = [NSString stringWithFormat:@"¥%@.0",model.frontTyrePrice];
        }
        self.spacing.constant = 8.f;
        self.TyreView2.hidden = YES;
    }else{
        
        //前后轮不一致
        self.commodityNameLab.text = model.frontTyreName;
        [self.commodityPhotoView sd_setImageWithURL:[NSURL URLWithString:model.frontOrderImg]];
        self.commodityPriceLab.text = [NSString stringWithFormat:@"¥%@.0",model.frontTyrePrice];
        self.commodityNameLab2.text = model.rearTyreName;
        [self.commodityPhotoView2 sd_setImageWithURL:[NSURL URLWithString:model.rearOrderImg]];
        self.commodityPriceLab2.text = [NSString stringWithFormat:@"¥%@.0",model.rearTyrePrice];
        
        self.spacing.constant = 106.f;
        self.TyreView2.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
