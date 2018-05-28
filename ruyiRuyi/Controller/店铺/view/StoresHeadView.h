//
//  StoresHeadView.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/24.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresHeadView : UIView

@property(nonatomic,strong)UIImageView *subImg;

@property(nonatomic,strong)UILabel *titlLab;

@property(nonatomic,strong)UIButton *leftBtn;

@property(nonatomic,strong)UIButton *rigBtn;

@property(nonatomic,copy)NSString *monthIncomeStr;

@property(nonatomic,copy)NSString *totalIncomeStr;


@end
