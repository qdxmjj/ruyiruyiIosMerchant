//
//  AppDelegate.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    BMKMapManager* _mapManager;

}

@property (strong, nonatomic) UIWindow *window;


@end

