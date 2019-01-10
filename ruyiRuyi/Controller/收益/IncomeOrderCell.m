//
//  IncomeOrderCell.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeOrderCell.h"
#import "UIImage+ImageRoundedCorner.h"

#import "ServiceIncomeModel.h"
#import "CommodityIncomeModel.h"
#import "SellIncomeModel.h"
#import "AdditionalIncomeModel.h"
@implementation IncomeOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImage *image = [UIImage imageNamed:@"shareIMG"];
    image = [image imageAddCornerWithRadius:25.f andSize:CGSizeMake(50, 50)];
    self.serviceIncomeImageView.image = image;

    UIImage *saleImage = [UIImage imageNamed:@"shareIMG"];
    saleImage = [saleImage imageAddCornerWithRadius:40.f andSize:CGSizeMake(80, 80)];
    self.otherIncomeImageView.image = saleImage;
}

-(void)setIncomeInfoByModel:(IncomeModel *)model withModelType:(incomeType)type{
    
    switch (type) {
        case ServiceIncomeType:{
            
            ServiceIncomeModel *sModel = (ServiceIncomeModel *)model;
            
            self.orderNumberLab.text = [NSString stringWithFormat:@"订单编号：%@",sModel.orderNo];
            self.s_priceLab.text = [NSString stringWithFormat:@"+%@",sModel.earnings];
            self.s_dateLab.text = [JJTools getTimestampFromTime:[NSString stringWithFormat:@"%@",sModel.createdTime] formatter:nil];

            NSString *orderTypeS = [sModel.orderType longLongValue] == 0?@"轮胎购买订单":[sModel.orderType longLongValue] == 1?@"普通商品购买订单":[sModel.orderType longLongValue] == 2?@"首次更换订单":[sModel.orderType longLongValue] == 3?@"轮胎订单":[sModel.orderType longLongValue] == 4?@"免费再换订单":[sModel.orderType longLongValue] == 5?@"轮胎修补订单":@"状态异常";
            self.serviceNameLab.text = orderTypeS;
        }
            break;
        case CommodityIncomeType:{
            
            CommodityIncomeModel *cModel = (CommodityIncomeModel *)model;
            self.orderNumberLab.text = [NSString stringWithFormat:@"订单编号：%@",cModel.orderNo];
            self.s_priceLab.text = [NSString stringWithFormat:@"+%@",cModel.earnings];
            self.s_dateLab.text = [JJTools getTimestampFromTime:[NSString stringWithFormat:@"%@",cModel.createdTime] formatter:nil];
            
            NSString *orderTypeS = [cModel.orderType longLongValue] == 0?@"轮胎购买订单":[cModel.orderType longLongValue] == 1?@"普通商品购买订单":[cModel.orderType longLongValue] == 2?@"首次更换订单":[cModel.orderType longLongValue] == 3?@"轮胎订单":[cModel.orderType longLongValue] == 4?@"免费再换订单":[cModel.orderType longLongValue] == 5?@"轮胎修补订单":@"状态异常";

            self.serviceNameLab.text = orderTypeS;
        }
            break;
        case SellIncomeType:{
            
            SellIncomeModel *sellModel = (SellIncomeModel *)model;
            
            self.otherIncomeNameLab.text = sellModel.shoeName;
            self.otherIncomePriceLab.text = [NSString stringWithFormat:@"+%@",sellModel.earnings];
            self.otherDateLab.text = [JJTools getTimestampFromTime:[NSString stringWithFormat:@"%@",sellModel.createdTime] formatter:nil];
            self.otherDetailsLab.text = [NSString stringWithFormat:@"数量：%@",sellModel.totalShoeNo];
        }
            break;
        case AdditionalIncomeType:{
            
            AdditionalIncomeModel *a_Model = (AdditionalIncomeModel *) model;
            
            self.otherIncomeNameLab.text = @"绑定app奖励";
            self.otherIncomePriceLab.text = [NSString stringWithFormat:@"+%@",a_Model.earnings];
            self.otherDateLab.text = [JJTools getTimestampFromTime:[NSString stringWithFormat:@"%@",a_Model.createdTime] formatter:nil];
            self.otherDetailsLab.text = [NSString stringWithFormat:@"受邀用户:%@",a_Model.phone];
        }
            break;
        default:
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
