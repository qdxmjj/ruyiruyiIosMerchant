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

#import <AFNetworking.h>

#import <AlipaySDK/AlipaySDK.h>

#import <Bugly/Bugly.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static NSString * const JPushAppKey = @"58b63697b0ef833709106bac"; //推送的appkey

static NSString * const channel = @"App Store";

static BOOL isProduction = true; //开发环境, true则为生产环境

@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    NSDictionary *_data;

}
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
    [self.window makeKeyAndVisible];
    //----------------- 百度地图 -------------------
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"wjUDClrGGndu7VvyRT4VFrVEPWd3qO8t"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    //-----------------微信---------------------
    [WXApi registerApp:@"wx50b5fdd4369dc4c4"
    universalLink:@"https://xf62o.share2dlink.com/"];
    
    [Bugly startWithAppId:@"3df5353770"];
    
    //-----------------mob分享---------------------
    [JJShare ShareRegister];
    //-----------------f更新-------------------
    [self checkVersion];
    //-----------------极光推送---------------------
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    //未登录不注册别名
    if (yesOnNO) {
        [JPUSHService setAlias:[UserConfig phone] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            NSLog(@"%ld   %@",(long)iResCode,iAlias);
        } seq:0];
    }
   
    return YES;
}

- (void)checkVersion{
    
    //app store生成的地址
    NSString *URL = @"https://itunes.apple.com/cn/lookup?id=1347670578";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",results);
    NSData *data = [results dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",dic);
    _data = dic;
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        // 取当前版本的版号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"appstorversion:%@  产品版本:%@",lastVersion,currentVersion);
        if ([currentVersion compare:lastVersion]==NSOrderedAscending) {// 比对版本号
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本" message:@"是否前往更新" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UIApplication *application = [UIApplication sharedApplication];
                NSString *url = self->_data[@"results"][0][@"trackViewUrl"];
                [application openURL:[NSURL URLWithString:url]];
            }];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            }];
            //0 不强制更新
            [alertController addAction:ok];
//            [alertController addAction:cancel];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }
}

#pragma mark pay

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:nil];
            }else{
                
                [MBProgressHUD showTextMessage:@"支付宝支付失败"];
            }
        }];
    }
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:nil];
            }else{
                
                [MBProgressHUD showTextMessage:@"支付宝支付失败"];
            }
        }];
    }
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
#pragma mark WXApiDelegate
- (void)onResp:(BaseResp *)resp{
    
    //WXSuccess           = 0,    /**< 成功    */
    //WXErrCodeCommon     = -1,   /**< 普通错误类型    */
    //WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    //WXErrCodeSentFail   = -3,   /**< 发送失败    */
    //WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
    //WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        
        if (resp.errCode == 0) {
            
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            NSDictionary *dict = @{@"key":resp2.code};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weiXinLoginCallBack" object:nil userInfo:dict];
        }else{
            
            [MBProgressHUD showTextMessage:@"微信登录失败!"];
        }
    }else{
        
        if (resp.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:nil];
        }else if (resp.errCode == -1){
            [MBProgressHUD showTextMessage:@"普通错误类型！"];
        }else if (resp.errCode == -2){
            [MBProgressHUD showTextMessage:@"用户取消支付！"];
        }else if (resp.errCode == -3){
            [MBProgressHUD showTextMessage:@"发送失败！"];
        }else if (resp.errCode == -4){
            [MBProgressHUD showTextMessage:@"授权失败！"];
        }else if (resp.errCode == -5){
            [MBProgressHUD showTextMessage:@"微信不支持！"];
        }
    }
}



#pragma mark JPUSH Delegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    } else {
        // Fallback on earlier versions
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}



- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];

    NSLog(@"ID：%@",JPUSHService.registrationID);

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"极光推送注册token失败 Error: %@", error);
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
