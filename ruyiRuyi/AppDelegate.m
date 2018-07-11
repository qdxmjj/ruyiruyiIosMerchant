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
#import "MyUncaughtExceptionHandler.h"
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

    
//    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@""]];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@""]];
    

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
    
    
    
    [[Harpy sharedInstance] setPresentingViewController:_window.rootViewController];

    //如要使用代理方法 可选签订
//    [[Harpy sharedInstance] setDelegate:self];

    //可选）设置此选项后，仅当当前版本已发布X天时才会显示警报。
    //默认情况下，此值设置为1（天），以避免Apple更新JSON的速度快于应用程序二进制文件传播到App Store的问题。
    [[Harpy sharedInstance] setShowAlertAfterCurrentVersionHasBeenReleasedForDays:1];

    //设置提示文字颜色
    [[Harpy sharedInstance] setAlertControllerTintColor:[UIColor redColor]];

    //设置提示应用程序名
    [[Harpy sharedInstance] setAppName:@"如意如驿商家版"];
    
    
    /*（可选）设置应用的警报类型
    默认情况下，Harpy配置为使用HarpyAlertTypeOption */
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeOption];
    
    /*（可选）如果您的应用程序在美国App Store中不可用，则必须指定两个字母
    您的应用程序所在地区的国家/地区代码。*/
    [[Harpy sharedInstance] setCountryCode:@"CHN"];
    
    /*如果设置，将会把语言设置为指定语言，不跟随系统文字*/
    [[Harpy sharedInstance] setForceLanguageLocalization:HarpyLanguageChineseSimplified];
    //开始执行检查
    [[Harpy sharedInstance] checkVersion];
    
    //注册消息处理函数的处理方法
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    // 发送崩溃日志
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    if (data != nil) {
        
        [self sendExceptionLogWithData:data path:dataPath];
        
    }
    return YES;
}

#pragma mark -- 发送崩溃日志
- (void)sendExceptionLogWithData:(NSData *)data path:(NSString *)path {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0f;
    //告诉AFN，支持接受 text/xml 的数据
    [AFJSONResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSString *urlString = @"后台地址";
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:@"Exception.txt" mimeType:@"txt"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 删除文件
        NSFileManager *fileManger = [NSFileManager defaultManager];
        [fileManger removeItemAtPath:path error:nil];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
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
    
    /*
     Perform check for new version of your app
     Useful if user returns to you app from background after being sent tot he App Store,
     but doesn't update their app before coming back to your app.
     
     ONLY USE THIS IF YOU ARE USING *HarpyAlertTypeForce*
     
     Also, performs version check on first launch.
     */
    
    /*
     检查您的应用的新版本
     如果用户在发送到App Store后从后台返回应用程序，则非常有用，
     但在回到您的应用之前不会更新他们的应用。
     
     注意：只有当你使用*HarpyAlertTypeForce*样式弹框类型是才使用这种方法

       此外，首次启动时执行版本检查。
      */
//    [[Harpy sharedInstance] checkVersion];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //每天检查新版本
    [[Harpy sharedInstance] checkVersionDaily];

    //每周检查新版本
//    [[Harpy sharedInstance] checkVersionWeekly];

    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
