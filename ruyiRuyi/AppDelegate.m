//
//  AppDelegate.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "RootViewController.h"
#import "BaseNavigation.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MyCommodityViewController.h"
#import "JJMacro.h"
#import "JJShare.h"
#import <Harpy.h>
#import <Bugly/Bugly.h>
#import <AFNetworking.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
   
    keyboardManager.toolbarDoneBarButtonItemText = @"完成";
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    self.window =[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    NSString *yesOnNO = [UserConfig userDefaultsGetObjectForKey:kFirstLogIn];

    if (!yesOnNO) {
        
        BaseNavigation *nav = [[BaseNavigation alloc] initWithRootViewController: [[LogInViewController alloc] init]];
        self.window.rootViewController = nav;
    }else{
        
        self.window.rootViewController = [[RootViewController alloc]init];
    }

    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"wjUDClrGGndu7VvyRT4VFrVEPWd3qO8t"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    // Add the navigation controller's view to the window and display.
    [self.window makeKeyAndVisible];
    
    [WXApi registerApp:@"wxe7d25890f6c97a1a"];
    
    [JJShare ShareRegister];
    
    [self configureBugly];

    return YES;
}

#pragma mark -- bugly
- (void)configureBugly {
    
    BuglyConfig *config = [[BuglyConfig alloc] init];
    
    config.unexpectedTerminatingDetectionEnable = YES; //非正常退出事件记录开关，默认关闭
    config.reportLogLevel = BuglyLogLevelVerbose; //报告级别
    //config.deviceIdentifier = [UIDevice currentDevice].identifierForVendor.UUIDString; //设备标识
    config.blockMonitorEnable = YES; //开启卡顿监控
    config.blockMonitorTimeout = 5; //卡顿监控判断间隔，单位为秒
    //    config.delegate = self;
    
#if DEBUG
    config.debugMode = YES; //SDK Debug信息开关, 默认关闭
    config.channel = @"debug";
#else
    config.channel = @"release";
#endif
    
    [Bugly startWithAppId:@"3df5353770"
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
