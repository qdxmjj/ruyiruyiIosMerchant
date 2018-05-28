//
//  TiresCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/23.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiresModel.h"
@interface TiresCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shoeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *fontRearFlagLab;
@property (weak, nonatomic) IBOutlet UILabel *fontAmountLab;
@property (weak, nonatomic) IBOutlet UIImageView *shoeImgView;


-(void)setTiresModel:(TiresModel *)model orderType:(NSString *)orderType;


@end
