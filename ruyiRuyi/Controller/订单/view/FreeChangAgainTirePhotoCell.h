//
//  FreeChangAgainTirePhotoCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeChangAgainTirePhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *codeNumberLab;

@property (weak, nonatomic) IBOutlet UIButton *selectTirePhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteTirePhotoBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectBarCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *deleteBarCodeBtn;
@end
