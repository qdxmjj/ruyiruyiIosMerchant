//
//  HUDQueue.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "HUDQueue.h"
#import "MBProgressHUD+YYM_category.h"
@interface HUDQueue()


@end

@implementation HUDQueue

//+(instancetype)shareSingleton{
//
//    static HUDQueue *hudQueue = nil;
//
//    //给单例加了一个线程锁
//    static dispatch_once_t onceToken;
//
//    dispatch_once(&onceToken, ^{
//        hudQueue = [[HUDQueue alloc] init];
//
//    });
//
//    return hudQueue;
//}


-(void)addQueueTask:(NSString *)msg number:(int )number{
    
    //创建队列组
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        sleep(number);

        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD showTextMessage:msg];

        });

    });
    


    
}


@end
