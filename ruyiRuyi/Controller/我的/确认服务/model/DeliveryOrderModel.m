//
//  DeliveryOrderModel.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/9/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "DeliveryOrderModel.h"

@implementation DeliveryOrderModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.orderID = value;
    }
    

    if ([key isEqualToString:@"shoeOrderDTOList"]) {
        
        _tireList = value;
        
        NSInteger frontCount = 0;
        NSInteger rearCount = 0;
        
        for (NSDictionary *dic in value) {
            
            if ([[dic objectForKey:@"tyreFlag"] longLongValue] == 0 ) {
                
                self.frontTyreName  = [dic objectForKey:@"tyreName"];
                self.frontOrderImg  = [dic objectForKey:@"orderImg"];
                self.frontTyreId    = [dic objectForKey:@"tyreId"];
                self.frontTyrePrice = [dic objectForKey:@"tyrePrice"];
                
                frontCount += [[dic objectForKey:@"tyreNum"] integerValue];
                self.isConsistent = YES;
            }
            
            if ([[dic objectForKey:@"tyreFlag"] longLongValue] == 1 ) {
                
                self.frontTyreName = [dic objectForKey:@"tyreName"];
                self.frontOrderImg = [dic objectForKey:@"orderImg"];
                self.frontTyreId   = [dic objectForKey:@"tyreId"];
                self.frontTyrePrice = [dic objectForKey:@"tyrePrice"];
                frontCount += [[dic objectForKey:@"tyreNum"] integerValue];
                self.isConsistent = NO;
            }
            
            if ([[dic objectForKey:@"tyreFlag"] longLongValue] == 2 ) {
                
                self.rearTyreName = [dic objectForKey:@"tyreName"];
                self.rearOrderImg = [dic objectForKey:@"orderImg"];
                self.rearTyreId = [dic objectForKey:@"tyreId"];
                self.rearTyrePrice = [dic objectForKey:@"tyrePrice"];
                rearCount += [[dic objectForKey:@"tyreNum"] integerValue];
                self.isConsistent = NO;
            }
        }
        
        self.frontTyre = [NSString stringWithFormat:@"%ld",frontCount];
        self.rearTyre  = [NSString stringWithFormat:@"%ld",rearCount];
    }
}

@end
