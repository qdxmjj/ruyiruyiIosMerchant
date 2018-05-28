//
//  MyOrdersCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/21.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrdersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ordersName;
@property (weak, nonatomic) IBOutlet UILabel *ordersNumber;
@property (weak, nonatomic) IBOutlet UILabel *ordersPrice;
@property (weak, nonatomic) IBOutlet UILabel *ordersStatus;
@property (weak, nonatomic) IBOutlet UIImageView *ordersImg;

@end
