//
//  ShopItemCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopItemCell : UITableViewCell

@property(nonatomic,strong)NSArray *shopItemArr;//所有的服务项目

@property(nonatomic,strong)NSArray *defaultSelectItems;//默认选中的服务项目

-(NSArray *)selelItems;//获取到选中的collectionViewCell

@end
