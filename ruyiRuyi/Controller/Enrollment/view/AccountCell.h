//
//  AccountCell.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJRequest.h"
@interface AccountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *userField;//用户名
@property (weak, nonatomic) IBOutlet UITextField *phoenField;//用户手机号

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;//验证码


@property (weak, nonatomic) IBOutlet UITextField *passwordField;//密码
@property (weak, nonatomic) IBOutlet UITextField *checkPswdField;//确认密码

@end
