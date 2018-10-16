//
//  IncomeOrderCell.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/9/29.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeModel.h"
#import "JJTools.h"
@interface IncomeOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *s_priceLab;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLab;
@property (weak, nonatomic) IBOutlet UILabel *s_dateLab;
@property (weak, nonatomic) IBOutlet UIImageView *serviceIncomeImageView;



@property (weak, nonatomic) IBOutlet UILabel *otherIncomeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *otherIncomePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *otherDateLab;
@property (weak, nonatomic) IBOutlet UILabel *otherDetailsLab;
@property (weak, nonatomic) IBOutlet UIImageView *otherIncomeImageView;

-(void)setIncomeInfoByModel:(IncomeModel *)model withModelType:(incomeType )type;

@end
