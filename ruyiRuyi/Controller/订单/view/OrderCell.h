//
//  OrderCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrdersModel.h"
@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *orderImg;
@property (weak, nonatomic) IBOutlet UILabel *ordersType;
@property (weak, nonatomic) IBOutlet UILabel *carNumber;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;

-(void)setModel:(OrdersModel *)model;

@end
