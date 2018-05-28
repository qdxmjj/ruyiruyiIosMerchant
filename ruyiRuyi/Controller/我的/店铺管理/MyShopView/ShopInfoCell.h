//
//  ShopInfoCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *storeTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *storeTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *storePhoneLab;
@property (weak, nonatomic) IBOutlet UISwitch *operateSwitch;
@property (weak, nonatomic) IBOutlet UILabel *storeCityLab;
@property (weak, nonatomic) IBOutlet UILabel *storeLocationLab;

@end
