//
//  IncomeModel.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/15.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeModel.h"
#import "ServiceIncomeModel.h"
#import "CommodityIncomeModel.h"
#import "SellIncomeModel.h"
#import "AdditionalIncomeModel.h"
@implementation IncomeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(IncomeModel *)initWithType:(incomeType)type{
    
    IncomeModel *model = nil;
    
    switch (type) {
        case ServiceIncomeType:
            
            model = [[ServiceIncomeModel alloc] init];
            break;
        case CommodityIncomeType:
            
            
            model = [[CommodityIncomeModel alloc] init];
            break;
        case SellIncomeType:
            
            model = [[SellIncomeModel alloc] init];
            break;
        case AdditionalIncomeType:
            
            model = [[AdditionalIncomeModel alloc] init];
            break;
        default:
            break;
    }
    
    return model;
}

@end
