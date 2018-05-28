//
//  MainStoresCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/24.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoresModel.h"

@interface MainStoresCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeOrdersImg;
@property (weak, nonatomic) IBOutlet UILabel *storeOrdersTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *storeOrdersDateLab;
@property (weak, nonatomic) IBOutlet UILabel *storeOrdersPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *storeOrdersStatusLab;


-(void)setModel:(StoresModel *)model;

@end
