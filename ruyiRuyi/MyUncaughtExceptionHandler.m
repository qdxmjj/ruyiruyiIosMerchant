//
//  MyUncaughtExceptionHandler.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/10.
//  Copyright © 2018年 如驿如意. All rights reserved.
//


#import "MyUncaughtExceptionHandler.h"

@implementation MyUncaughtExceptionHandler

void uncaughtExceptionHandler(NSException *exception){
    
    
    
    NSArray *stackArry= [exception callStackSymbols];
    
    
    
    NSString *reason = [exception reason];
    
    
    
    NSString *name = [exception name];
    
    
    
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception name:%@\nException reatoin:%@\nException stack :%@",name,reason,stackArry];
    
    NSLog(@"%@",exceptionInfo);
    
    
    
    //保存到本地沙盒中
    
    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/eror.log",NSHomeDirectory()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    
    
}

@end
