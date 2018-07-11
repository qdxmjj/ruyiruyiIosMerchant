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
#import "JJMacro.h"
@implementation MainStoresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.accessoryType=UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.Voucher.layer.borderColor = [JJThemeColor CGColor];
    self.Voucher.layer.borderWidth = 1.f;

}

-(void)setModel:(StoresModel *)model{
    
    
    NSString *orderServiceTypeName = model.orderServcieTypeNameList[0];
    
    if ([orderServiceTypeName isEqualToString:@"汽车保养"]) {
        
        self.storeOrdersImg.image = [UIImage imageNamed:@"ic_baoyang"];
    }else if ([orderServiceTypeName isEqualToString:@"美容清洗"]) {
        
        self.storeOrdersImg.image = [UIImage imageNamed:@"ic_qingxi"];
    }else if ([orderServiceTypeName isEqualToString:@"安装改装"]) {
        
        self.storeOrdersImg.image = [UIImage imageNamed:@"ic_anzhuang"];
        
    }else{
//        [orderServiceTypeName isEqualToString:@"轮胎服务"]
        self.storeOrdersImg.image = [UIImage imageNamed:@"ic_luntai"];
    }
    
    
    self.storeOrdersTitleLab.text = [model.orderServcieTypeNameList componentsJoinedByString:@"\\"];
    
    self.storeOrdersDateLab.text =[JJTools getTimestampFromTime:model.orderTime formatter:@"yyyy-MM-dd"];
    
    if ([model.orderState integerValue] == 7||[model.orderState integerValue] == 1) {
        
        if ([model.orderPrice longLongValue] != [model.orderActuallyPrice longLongValue]) {
            
            self.Voucher.hidden = NO;
            self.voucherWidth.constant = 18.f;

        }else{
            
            self.Voucher.hidden = YES;
            self.voucherWidth.constant = 0.f;
        }
        self.storeOrdersPriceLab.textColor = [UIColor redColor];
        self.storeOrdersPriceLab.text = [NSString stringWithFormat:@"+ %@",model.orderActuallyPrice];
    }else{
        
        if ([model.orderPrice longLongValue] != [model.orderActuallyPrice longLongValue]) {

            self.Voucher.hidden = NO;
            self.voucherWidth.constant = 18.f;
        }else{
            
            self.Voucher.hidden = YES;
            self.voucherWidth.constant = 0.f;
        }
        self.storeOrdersPriceLab.text = [NSString stringWithFormat:@"%@",model.orderActuallyPrice];
        self.storeOrdersPriceLab.textColor = JJFirstLevelFont;
    }
    
    NSString *status = [model.orderState longLongValue] == 1?@"已完成":[model.orderState longLongValue] == 2?@"待收货":[model.orderState longLongValue] == 3?@"待服务":[model.orderState longLongValue] == 4?@"作废":[model.orderState longLongValue] == 5?@"待发货":[model.orderState longLongValue] == 6?@"待车主确认服务":[model.orderState longLongValue] == 7?@"待评价":[model.orderState longLongValue] == 8?@"待支付":[model.orderState longLongValue] == 9?@"退款中":[model.orderState longLongValue] == 10?@"已退款":[model.orderState longLongValue] == 15?@"用户已取消":@"状态异常";
    
    self.storeOrdersStatusLab.text = status;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
