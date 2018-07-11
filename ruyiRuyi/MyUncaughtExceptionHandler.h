//
//  MyUncaughtExceptionHandler.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUncaughtExceptionHandler : NSObject

//// 崩溃时的回调函数

void uncaughtExceptionHandler(NSException *exception);

@end
