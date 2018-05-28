//
//  UserConfig.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject


+(void)userDefaultsSetObject:(id)object key:(NSString *)key;

+(id)userDefaultsGetObjectForKey:(NSString *)key;

+(NSString *)address;//详细位置

+(NSString *)appExpert;//手机熟练度

+(NSString *)balance;//

+(NSString *)businessLicenseUrl;//许可证img

+(NSString *)cityId;//城市ID

+(NSString *)createTime;//开始时间

+(NSString *)endTime;//结束时间

+(NSString *)factoryImgUrl;//商店img

+(NSString *)storeID;//商家ID

+(NSString *)idImgUrl;//身份证

+(NSString *)indoorImgUrl;//

+(NSString *)latitude;//纬度

+(NSString *)locationImgUrl;//

+(NSString *)longitude;//经度

+(NSString *)phone;//账号

+(NSString *)positionId;//

+(NSString *)producerId;//

+(NSString *)producerName;//用户名

+(NSString *)situation;//

+(NSString *)starNo;//

+(NSString *)startTime;//

+(NSString *)status;//

+(NSString *)storeImgUrl;//默认头像

+(NSString *)storeLocation;//

+(NSString *)storeLoginName;//

+(NSString *)storeName;//商铺名称

+(NSString *)storeTypeId;//

+(NSString *)tel;//

+(NSString *)token;//

+(NSString *)updateTime;//账

@end
