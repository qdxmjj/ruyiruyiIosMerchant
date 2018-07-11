//
//  TireRepairBarCodeCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TireRepairBarCodeModel.h"

typedef void (^updateCellBlock)(CGFloat value);

@interface TireRepairBarCodeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *barCodelab;

-(void)setModel:(TireRepairBarCodeModel *)model;

-(void)setStepperViewHidden:(BOOL )hidden;

@property(nonatomic,copy)updateCellBlock updateBlock;

@end
