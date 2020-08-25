//
//  BaseModel.m
//  ronghetongxun
//
//  Created by yym on 2020/5/11.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//打印所有属性
MJExtensionLogAllProperties

//实现NSCoding协议，归档解档
MJExtensionCodingImplementation

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"descriptions": @"description",
             @"ids": @"id",
             @"classs": @"class"};
}
+ (instancetype)model {
    return [[[self class] alloc] init];
}

//把null的字段转换为空字符串
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    //把null属性处理成空字符串
    if ([oldValue isKindOfClass:[NSNull class]])
    {
        if (property.type.isNumberType){
            return 0;
        }else if (property.type.isBoolType){
            return 0;
        }else if ([property.type.code isEqualToString:@"NSArray"]){
            return @[];
        }else{
            return @"";
        }
    }
    //把没有的字段处理成空字符串
    if (!oldValue)
    {
        if (property.type.isNumberType){
            return 0;
        }else if (property.type.isBoolType){
            return 0;
        }else if ([property.type.code isEqualToString:@"NSArray"]){
            return @[];
        }else if ([property.type.code isEqualToString:@"NSString"]){
            return @"";
        }else{
            return nil;
        }
    }
    return oldValue;
}
@end
