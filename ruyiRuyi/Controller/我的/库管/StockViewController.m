//
//  StockViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/21.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "StockViewController.h"
#import "OrderGoodsViewController.h"
#import "OrderManageViewController.h"
#import "BondViewController.h"
#import "StockManageController.h"
@interface StockViewController ()<UINavigationControllerDelegate>

@end

@implementation StockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;

}
- (IBAction)popViewControllerAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)orderAction:(id)sender {

    OrderManageViewController *vc = [[OrderManageViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)orderGoodsAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[OrderGoodsViewController alloc]init] animated:YES];
}
- (IBAction)bondAction:(id)sender {
    BondViewController *vc = [[BondViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)stockManageAction:(id)sender {
    StockManageController *vc = [[StockManageController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isMemberOfClass:[StockViewController class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


@end
