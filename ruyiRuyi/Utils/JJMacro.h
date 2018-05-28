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

#define JJThemeColor  [UIColor colorWithRed:255.f/255 green:102.f/255 blue:35.f/255 alpha:1.f]

#define JJWeakSelf __weak typeof(self) weakSelf = self;



//#define RuYiRuYiIP  @"http://192.168.0.190:8060"
#define RuYiRuYiIP  @"http://192.168.0.167:8082/xmjj-webservice"

// 判断是否是iPhone X
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// home indicator
#define bottom_height (KIsiPhoneX ? 34.f : 10.f)

#ifdef DEBUG
#define YLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

#define KstoreImgUrl    @"KstoreImgUrl"
#define KproducerName    @"KproducerName"
#define KstoreID    @"kstoreID"
#define kArea   @"kArea"
#define kAddress    @"kAddress"
#define kAvatar @"kAvatar"
#define kToken  @"kToken"
#define kUser_name  @"kUser_name"
#define kStoreName  @"kStoreName"
#define kPassword   @"kPassword"
#define kAccount    @"kAccount"

#endif /* JJMacro_h */
