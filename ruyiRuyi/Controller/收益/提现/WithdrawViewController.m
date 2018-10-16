//
//  WithdrawViewController.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/16.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "WithdrawViewController.h"
#import "VTCodeView.h"
@interface WithdrawViewController ()

@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
}
- (IBAction)fullWithdrawalEvent:(UIButton *)sender {
    
    VTCodeView *vtcodeView = [[VTCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [vtcodeView showWithSuperView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
