//
//  CommodityTypeModel.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "CommodityTypeModel.h"

@implementation CommodityTypeModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"美容清洗"]) {
        
        _meirongqingxi = value;
    }
    
    if ([key isEqualToString:@"安装"]) {
        
        _anzhuang = value;
    }
    
    if ([key isEqualToString:@"汽车保养"]) {
        
        _qichebaoyang = value;
    }
    
    if ([key isEqualToString:@"轮胎服务"]) {
        
        _luntaifuwu = value;
    }
    
}


@end
