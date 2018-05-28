//
//  SellingCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/14.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sellingModel.h"
@interface SellingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commodityImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *stocklab;
@property (weak, nonatomic) IBOutlet UILabel *soldLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

-(void)setValueWithModel:(sellingModel *)model;
@end
