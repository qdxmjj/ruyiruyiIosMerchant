//
//  HanderView.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "UIButton+ImageTitleSpacing.h"
#import <UIImageView+WebCache.h>
@interface HanderView : UIView


@property(nonatomic,copy)NSString *userName;

@property(nonatomic,copy)NSString *Avatar;


@property(nonatomic,strong)UIButton *leftBtn;

@property(nonatomic,strong)UIButton *rigBtn;
@end
