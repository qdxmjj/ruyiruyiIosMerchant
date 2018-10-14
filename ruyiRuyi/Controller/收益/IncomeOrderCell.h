//
//  IncomeOrderCell.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeModel.h"
@interface IncomeOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *serviceCellImageView;

@property (weak, nonatomic) IBOutlet UIImageView *saleCellImageView;
-(void)setIncomeInfoByModel:(IncomeModel *)model;

@end
