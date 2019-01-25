//
//  RootViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "RootViewController.h"
#import "BaseNavigation.h"
#import "UserViewController.h"
#import "OrdersViewController.h"
#import "StoresViewController.h"
#import "IncomeViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
    
    OrdersViewController *ordersVC = [[OrdersViewController alloc] init];

    StoresViewController *storeVC = [[StoresViewController alloc] init];
    
    UserViewController *myVC = [[UserViewController alloc] init];

    IncomeViewController *incomeVC = [[IncomeViewController alloc] init];

    
    [self setController:ordersVC title:@"平台订单" imageString:@"ic_tubiao1" selectedImageString:@"ic_tubiao1_xuanzhong"];
    [self setController:storeVC title:@"店铺订单" imageString:@"ic_shop_weixuan" selectedImageString:@"ic_shop_xuanzhong"];
    [self setController:incomeVC title:@"收益" imageString:@"ic_shouyi" selectedImageString:@"ic_shouyi_xz"];
    [self setController:myVC title:@"我的" imageString:@"ic_wode_weixuan" selectedImageString:@"ic_wode_xuanzhong"];
    

}

-(void)setController:(UIViewController *)controller title:(NSString *)title imageString:(NSString *)image selectedImageString:(NSString *)selectedImageString
{
    BaseNavigation *nav = [[BaseNavigation alloc] initWithRootViewController:controller];
    nav.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageString]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nav.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
    controller.title=title;
    
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [nav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

-(void)dealloc{
    NSLog(@"%@已释放!",[self class]);
}

@end
