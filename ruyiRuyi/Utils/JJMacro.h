//
//  JJMacro.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#ifndef JJMacro_h
#define JJMacro_h

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define STATUS_BAR_FRAME [[UIApplication sharedApplication] statusBarFrame]

#define JJThemeColor  [UIColor colorWithRed:255.f/255 green:102.f/255 blue:35.f/255 alpha:1.f]
#define JJFirstLevelFont [UIColor colorWithRed:66.f/255.f green:66.f/255.f blue:66.f/255.f alpha:1.f]

#define JJSecondaryFont [UIColor colorWithRed:33.f/255.f green:33.f/255.f blue:33.f/255.f alpha:1.f]

#define JJWeakSelf __weak typeof(self) weakSelf = self;
#define JJStrongSele __strong __typeof (self) strongSelf = self

//推送


//测试版IP
//#define GL_RuYiRuYiIP  @"http://192.168.0.190:8030"  //龚林 测试发货ID
#define GL_RuYiRuYiIP  @"http://180.76.243.205:10004"  //龚林  正式发货ID


//#define RuYiRuYiIP  @"http://192.168.0.190:8060"  //龚林 测试
//#define RuYiRuYiIP  @"http://192.168.0.60:8060"  //于鹏鹉 测试
//#define RuYiRuYiIP  @"http://192.168.0.111:8060"  //于鹏鹉 测试
//#define RuYiRuYiIP  @"http://192.168.0.167:8082/xmjj-webservice" // 测试

#define RuYiRuYiIP  @"http://180.76.243.205:10002/xmjj-webservice" //正式版IP

// 判断是否是iPhone X
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone4S
#define IS_iPhone_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone5 iPhone5s iPhoneSE
#define IS_iPhone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone6 7 8
#define IS_iPhone_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

// iPhone6plus  iPhone7plus iPhone8plus
#define IS_iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

// home indicator
#define bottom_height (KIsiPhoneX ? 34.f : 0.f)

#define bar_height    (KIsiPhoneX ? 83.f : 49.f)

#define nav_height    (KIsiPhoneX ? 88.f : 64.f)

#ifdef DEBUG
#define YLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

//登录信息key
#define kStoreImgUrl    @"KstoreImgUrl"
#define KproducerName    @"KproducerName"
#define KstoreID    @"kstoreID"
#define kArea       @"kArea"
#define kAddress    @"kAddress"
#define kAvatar     @"kAvatar"
#define kToken      @"kToken"
#define kUser_name  @"kUser_name"
#define kStoreName  @"kStoreName"
#define kPassword   @"kPassword"
#define kAccount    @"kAccount"
#define kFirstLogIn @"kFirstLogIn"
#define kPhone      @"kPhone"
#endif /* JJMacro_h */
