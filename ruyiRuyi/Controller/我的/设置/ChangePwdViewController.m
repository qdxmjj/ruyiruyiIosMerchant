//
//  ChangePwdViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/25.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "JJRequest.h"
#import "BaseNavigation.h"
#import "LogInViewController.h"
@interface ChangePwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *changepasswordTextField;

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"修改密码";
}


- (IBAction)changePasswordEvent:(UIButton *)sender {
 
    if ([self.accountTextField.text isEqualToString:@""]||[self.oldPasswordTextField.text isEqualToString: @""] ||[self.changepasswordTextField.text isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"输入信息不完成！"];
        return;
    }
    
    if (self.oldPasswordTextField.text.length<6 ||self.changepasswordTextField.text.length<6) {
        
        [MBProgressHUD showTextMessage:@"密码长度不足(密码最少六位)！"];
        return;
    }
    
    
   NSString *oldPwd = [MD5Encrypt MD5ForUpper32Bate:self.oldPasswordTextField.text];
   NSString *newPwd = [MD5Encrypt MD5ForUpper32Bate:self.changepasswordTextField.text];

    NSString *infoStr = [JJTools convertToJsonData:@{@"oldPassword":oldPwd,@"newPassword":newPwd,@"phone":self.accountTextField.text}];
    [JJRequest postRequest:@"changeStorePwdByOldPwd" params:@{@"reqJson":infoStr} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        if ([code longLongValue] == 1) {
            
            [UserConfig userDefaultsSetObject:nil key:kFirstLogIn];
            
            [[SDImageCache sharedImageCache] clearMemory];
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                
            }];
            
            BaseNavigation *nav = [[BaseNavigation alloc] initWithRootViewController: [[LogInViewController alloc] init]];
            [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
            
        }
        [MBProgressHUD showTextMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
