//
//  OrderDetailsViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/18.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrderDetailsViewController.h"

@interface OrderDetailsViewController ()

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


-(void)getOrdersInfo:(NSString *)orderNo orderType:(NSString *)orderType storeId:(NSString *)storeId{
    
    [MBProgressHUD showWaitMessage:@"正在获取订单..." showView:self.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
