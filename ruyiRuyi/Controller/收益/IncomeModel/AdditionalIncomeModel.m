//
//  AdditionalIncomeModel.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/15.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AdditionalIncomeModel.h"

@implementation AdditionalIncomeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.additionalIncomeID = value;
    }
}
@end
