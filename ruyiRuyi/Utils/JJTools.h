//
//  JJTools.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JJTools : NSObject

+ (BOOL)valiMobile:(NSString *)mobile;//判断是否手机号

+(NSString *)getTimestampFromTime:(NSString *)timeStampString formatter:(NSString *)format;//时间戳转时间

+(NSString *)convertToJsonData:(id )object;//字典转json

+(UIImage *)imageWithColor:(UIColor *)color;//颜色转图片

+(UIColor *)getColor:(NSString *)hexColor;//16进制颜色转RGB

+(NSMutableAttributedString *)priceWithRedString:(NSString *)red;


@end
