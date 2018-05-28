//
//  JJMapViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^LocationBlock)(CGFloat longitude,CGFloat latitude,NSString *storePosition);
@interface JJMapViewController : BaseViewController

@property(nonatomic,copy)LocationBlock locationBlock;

@end
