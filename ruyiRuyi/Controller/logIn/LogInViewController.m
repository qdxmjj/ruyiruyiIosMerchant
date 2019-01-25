//
//  LogInViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "LogInViewController.h"
#import "ResetPwdViewController.h"
#import "EnrollmentViewController.h"
#import "RootViewController.h"
#import "LogInrequestData.h"

#import <JPUSHService.h>
@interface LogInViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (IBAction)btnClickEvent:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"注册"]) {
        
        [self.navigationController pushViewController:[[EnrollmentViewController alloc]init] animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"忘记密码?"]){
        
        [self.navigationController pushViewController:[[ResetPwdViewController alloc]init] animated:YES];
        
    }else{
        
    }
    
}
- (IBAction)landEvent:(UIButton *)sender {
    
    

    if ([self.accountField.text isEqualToString:@""]||[self.pwdField.text isEqualToString:@""]) {

        [MBProgressHUD showTextMessage:@"请输入完整的账号密码!"];
        return;
    }

    [MBProgressHUD showWaitMessage:@"正在登录..." showView:self.view];
    
    NSDictionary *dic = @{@"phone":self.accountField.text,@"password":[MD5Encrypt MD5ForUpper32Bate:self.pwdField.text]};
    

    [LogInrequestData logInRequestWithReqJson:[JJTools convertToJsonData:dic] succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {

        [MBProgressHUD hideWaitViewAnimated:self.view];
        
        if ([code longLongValue]==111111) {

            [UserConfig userDefaultsSetObject:[data objectForKey:@"producerName"] key:KproducerName];
            [UserConfig userDefaultsSetObject:[data objectForKey:@"storeImgUrl"] key:kStoreImgUrl];
            [UserConfig userDefaultsSetObject:[data objectForKey:@"id"] key:KstoreID];
            [UserConfig userDefaultsSetObject:[data objectForKey:@"storeName"] key:kStoreName];
            [UserConfig userDefaultsSetObject:[data objectForKey:@"token"] key:kToken];

            [UserConfig userDefaultsSetObject:[data objectForKey:@"phone"] key:kPhone];

            [UserConfig userDefaultsSetObject:@"yes" key:kFirstLogIn];
            
            //登录注册别名用于指定推送
            [JPUSHService setAlias:[data objectForKey:@"phone"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
                NSLog(@"%ld   %@",iResCode,iAlias);
            } seq:0];
            
            [[UIApplication sharedApplication].keyWindow setRootViewController:[[RootViewController alloc]init]];
        }
        
    } failure:^(NSError * _Nullable error) {

        [MBProgressHUD hideWaitViewAnimated:self.view];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
