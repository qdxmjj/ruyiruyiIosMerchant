//
//  AssessCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssessModel.h"
@interface AssessCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *contentlab;

@property(nonatomic,strong)AssessModel *model;

@end
