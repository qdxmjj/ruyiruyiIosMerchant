//
//  BondViewController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/30.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "BondViewController.h"
#import "StockViewController.h"
#import "YMRequest.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
@interface BondViewController ()

@property (weak, nonatomic) IBOutlet UITextField *bondTextField;
@property (weak, nonatomic) IBOutlet UIButton *wxPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *havaMoneyLab;
@property (assign, nonatomic) NSInteger payType;
@end

@implementation BondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保证金";
    
    self.payType = 1;
    
    [self getBondInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:@"payStatus" object:nil];
}
- (void)getBondInfo{
    
    [MBProgressHUD showWaitMessage:@"正在获取保证金信息..." showView:self.view];
    
    
    [[YMRequest sharedManager] GET:[NSString stringWithFormat:@"%@%@",YMBaseUrl,kGetBond] parameters:@{@"user_id":[UserConfig storeID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if (responseObject[@"data"] && responseObject[@"data"] != [NSNull null] && responseObject[@"data"] != NULL) {
            NSArray *keys = [responseObject[@"data"] allKeys];
            
            if ([keys containsObject:@"total_money"]) {
                self.totalMoneyLab.text = [NSString stringWithFormat:@"%@元",responseObject[@"data"][@"total_money"]];
                self.allMoneyLab.text = [NSString stringWithFormat:@"%@元",responseObject[@"data"][@"all_money"]];
                self.havaMoneyLab.text = [NSString stringWithFormat:@"%@元",responseObject[@"data"][@"have_money"]];
            }
        }
        [MBProgressHUD hideWaitViewAnimated:self.view];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (void)paymentEvent{
    
    if (self.bondTextField.text.length <=0) {
        [MBProgressHUD showTextMessage:@"请输入保证金！"];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"正在发起支付..." showView:self.view];
    
    NSDictionary *params = @{@"userId":[UserConfig storeID],
                             @"payMone":self.bondTextField.text
    };
    
    [[YMRequest sharedManager] postRequest:kCashDepos params:params success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        if (code == 1) {
            if (self.payType == 1) {
                [self wxPay:data[@"orderNo"]];
            }else{
                [self aliPay:data[@"orderNo"]];
            }
        }else{
            [MBProgressHUD hideWaitViewAnimated:self.view];
            [MBProgressHUD showTextMessage:message];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (void)aliPay:(NSString *)orderNo{
    NSDictionary *params = @{@"userId":[UserConfig storeID],
                             @"orderNo":orderNo,
                             @"payMone":self.bondTextField.text};
    
    [[YMRequest sharedManager] postRequest:kGetAliPaySign params:params success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        if (code == 1) {
            
            NSLog(@"支付宝签名信息：%@",data);
            
            [[AlipaySDK defaultService] payOrder:[NSString stringWithFormat:@"%@",data] fromScheme:@"ruyiruyiMerchantiOS" callback:^(NSDictionary *resultDic) {
                NSLog(@"调用网页支付宝回调结果 = %@", resultDic);
                if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                    [MBProgressHUD showTextMessage:@"支付成功！"];
                    
                    [self paySuccess];
                }else{
                    [MBProgressHUD showTextMessage:@"支付失败"];
                }
            }];
        }else{
            [MBProgressHUD showTextMessage:message];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (void)wxPay:(NSString *)orderNo{
    
    NSDictionary *params = @{@"userId":[UserConfig storeID],
                             @"orderNo":orderNo,
                             @"payMone":self.bondTextField.text};
    
    [[YMRequest sharedManager] postRequest:kGetWeixinPaySign params:params success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if (code == 1) {
            NSDictionary *wxData = [JJTools dictionaryWithJsonString:data];
            wxData = wxData[@"data"];
            if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
                
                PayReq *req = [[PayReq alloc] init];
                req.openID = [wxData objectForKey:@"appid"];
                req.partnerId = [wxData objectForKey:@"partnerid"];
                req.prepayId = [wxData objectForKey:@"prepayid"];
                req.package = [wxData objectForKey:@"package"];
                req.nonceStr = [wxData objectForKey:@"noncestr"];
                req.timeStamp = [[wxData objectForKey:@"timestamp"] intValue];
                req.sign = [wxData objectForKey:@"sign"];
                [WXApi sendReq:req completion:^(BOOL success) {
                    if (success) {
                        [self paySuccess];
                    }else{
                        [MBProgressHUD showTextMessage:@"支付失败"];
                    }
                }];
            }else{
                [MBProgressHUD showTextMessage:@"未安装微信"];
            }
        }else{
            [MBProgressHUD showTextMessage:message];
        }
        
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideWaitViewAnimated:self.view];
    }];
}

- (IBAction)paySelectAction:(UIButton *)sender {
    
    if (sender == self.wxPayBtn) {
        self.aliPayBtn.selected = NO;
        self.payType = 1;
    }else{
        self.wxPayBtn.selected = NO;
        self.payType = 2;
    }
    sender.selected = YES;
}
- (IBAction)payAction:(id)sender {
    [self paymentEvent];
}

- (void)paySuccess{
    [MBProgressHUD showTextMessage:@"支付成功！"];
    
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[StockViewController class]]) {
            StockViewController *A =(StockViewController *)controller;
            [self.navigationController popToViewController:A animated:YES];
        }
    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"payStatus" object:nil];
    
}
@end
