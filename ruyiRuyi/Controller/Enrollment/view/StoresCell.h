//
//  StoresCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UITextField *storeName;//商店名称
@property (weak, nonatomic) IBOutlet UIButton *storeType;//商店类别

@property (weak, nonatomic) IBOutlet UITextField *storePhone;//商店联系电话
@property (weak, nonatomic) IBOutlet UIButton *storeTime;//商店营业时间
@property (weak, nonatomic) IBOutlet UIButton *storeCity;//商店所在城市
@property (weak, nonatomic) IBOutlet UITextField *storeLocation;//商店详细位置

@property (weak, nonatomic) IBOutlet UIButton *MapBtn;//商店定位位置

@property(nonatomic,copy)NSString *storeTypeID;

@property(nonatomic,copy)NSString *cityID;
@property(nonatomic,copy)NSString *areaID;


@end
