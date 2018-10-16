//
//  IncomeModel.h
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/15.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef  NS_ENUM(NSInteger , incomeType){
    
    ServiceIncomeType,
    CommodityIncomeType,
    SellIncomeType,
    AdditionalIncomeType,
};

@interface IncomeModel : NSObject

+ (IncomeModel *)initWithType:(incomeType)type;

@end
