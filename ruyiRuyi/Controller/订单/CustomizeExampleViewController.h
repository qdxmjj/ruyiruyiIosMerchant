//
//  CustomizeExampleViewController.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomizeExampleViewController : BaseViewController

/**
 * contentArr 显示提示内容数组 最少一条，最多不限
 */
@property(nonatomic,strong)NSMutableArray *contentArr;

/**
 * imgNameArr 显示的图片数组，最多两张最少一张
 */
@property(nonatomic,strong,nonnull)NSMutableArray *imgNameArr;

@end
