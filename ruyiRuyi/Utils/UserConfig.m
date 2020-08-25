//
//  UserConfig.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "UserConfig.h"
#import "JJMacro.h"
@implementation UserConfig

+(void)userDefaultsSetObject:(id)object key:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)userDefaultsGetObjectForKey:(NSString *)key{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }else{
        return NULL;
    }
}
+(NSString *)address{
    
    return [self userDefaultsGetObjectForKey:@"address"];
}
+(NSString *)storeImgUrl{
    
    return [self userDefaultsGetObjectForKey:kStoreImgUrl];
}
+(NSString *)producerName{
    
    return [self userDefaultsGetObjectForKey:KproducerName];
}
+(NSString *)storeID{
    return [self userDefaultsGetObjectForKey:KstoreID];
}
+(NSString *)storeName{
    
    return [self userDefaultsGetObjectForKey:kStoreName];
}
+(NSString *)token{
    
    return [self userDefaultsGetObjectForKey:kToken];
}
+(NSString *)phone{
    
    return [self userDefaultsGetObjectForKey:kPhone];
}

+ (NSString *)testIP{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testIP"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"testIP"];
    }else{
        return @"http://192.168.31.44:8922/";
    }
}
@end
