//
//  NewConfirmServiceCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/3.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryOrderModel.h"
@interface NewConfirmServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deliveryBtn;


@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIImageView *commodityPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *commodityNameLab;
@property (weak, nonatomic) IBOutlet UILabel *commodityPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *carIDLab;
@property (weak, nonatomic) IBOutlet UILabel *photoLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spacing;
@property (strong,nonatomic)DeliveryOrderModel *model;

@property (weak, nonatomic) IBOutlet UIView *TyreView2;
@property (weak, nonatomic) IBOutlet UIButton *deliveryBtn2;
@property (weak, nonatomic) IBOutlet UIImageView *commodityPhotoView2;
@property (weak, nonatomic) IBOutlet UILabel *commodityNameLab2;
@property (weak, nonatomic) IBOutlet UILabel *commodityPriceLab2;


@end
