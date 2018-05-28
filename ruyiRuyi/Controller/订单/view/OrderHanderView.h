//
//  OrderHanderView.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@interface OrderHanderView : UIView


@property(nonatomic,strong)UILabel *nameLab;

@property(nonatomic,strong)UILabel *titlLab;

@property(nonatomic,strong)UIButton *leftBtn;

@property(nonatomic,strong)UIButton *rigBtn;

@property(nonatomic,copy)NSString *unfinishedNum;

@property(nonatomic,copy)NSString *finishedNum;

@property(nonatomic,copy)NSString *totalNum;

@end
