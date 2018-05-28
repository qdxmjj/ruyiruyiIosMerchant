//
//  MyShopModel.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MyShopModel.h"

@implementation MyShopModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"storeName"]) {
        
        self.storeName = value;
    }
    if ([key isEqualToString:@"storeType"]) {
        
        self.storeType = value;
    }
    if ([key isEqualToString:@"storePhone"]) {
     
        self.storeTEL = value;
    }
    if ([key isEqualToString:@"storeLocation"]) {
        
        self.storeLocation = value;
    }
    if ([key isEqualToString:@"storeAddress"]) {
        
        self.storeAddress = value;
    }
    if ([key isEqualToString:@"storeEndTime"]) {
        
        self.storeEndTime = value;
    }
    if ([key isEqualToString:@"storeStartTime"]) {
        
        self.storeStartTime = value;
    }
    if ([key isEqualToString:@"status"]) {
        
        if ([value longLongValue] == 1) {
            
            self.isBusiness = YES;
        }else{
            self.isBusiness = NO;
        }
    }
    if ([key isEqualToString:@"factoryImgUrl"]) {
        
        self.factoryImgUrl = [NSURL URLWithString:value];
    }
    if ([key isEqualToString:@"indoorImgUrl"]) {
        
        self.indoorImgUrl = [NSURL URLWithString:value];
    }
    if ([key isEqualToString:@"locationImgUrl"]) {
        
        self.locationImgUrl = [NSURL URLWithString:value];
    }
    if ([key isEqualToString:@"storeServcieList"]) {
     
        self.storeServcieList = value;
    }
    
}
-(NSArray *)storeServcieList{
    
    if (!_storeServcieList) {
        
        _storeServcieList = [NSArray array];
    }
    
    return _storeServcieList;
}


-(NSString *)storeTime{
    
    if (self.storeStartTime == nil|| self.storeStartTime.length==0) {
        
        return @"";
    }
    
    NSString *time = [NSString stringWithFormat:@"%@至%@",[self.storeStartTime substringWithRange:NSMakeRange(11, 7)],[self.storeEndTime substringWithRange:NSMakeRange(11, 7)]];
    
    
    return time;
}

@end
