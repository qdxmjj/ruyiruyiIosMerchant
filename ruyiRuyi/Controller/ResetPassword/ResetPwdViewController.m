//
//  ResetPwdViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/4.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "EnrollmentRequestData.h"
#import "ResetPwdRequest.h"
@interface ResetPwdViewController ()
{
    NSInteger timeInt;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneFleld;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *checkPwdField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property(nonatomic,strong)NSTimer *time;

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(textFieldEditChanged:)   name:@"UITextFieldTextDidChangeNotification" object:self.codeField];
    

}


- (IBAction)resetPwdEvent:(id)sender {
    
    if ([self.phoneFleld.text isEqualToString:@""]) {
        
        [MBProgressHUD showTextMessage:@"手机号码为空!"];
        return;
    }else if ([self.codeField.text isEqualToString:@""]){
        
        [MBProgressHUD showTextMessage:@"验证码为空!"];

        return;
    }else if ([self.pwdField.text isEqualToString:@""]){
        
        [MBProgressHUD showTextMessage:@"密码为空!"];
        return;
    }else if([self.checkPwdField.text isEqualToString:@""]){
        
        [MBProgressHUD showTextMessage:@"确认密码为空!"];
        return;
    }
    
    if (![self.pwdField.text isEqualToString:self.checkPwdField.text]) {
        
        [MBProgressHUD showTextMessage:@"两次密码不一致!"];
        return;
    }
    
    [ResetPwdRequest changeStorePwdWithInfo:@{@"password":[MD5Encrypt MD5ForUpper32Bate:self.pwdField.text],@"phone":self.phoneFleld.text,@"code":self.codeField.text} succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
       
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


- (IBAction)getCodeEvent:(UIButton *)sender {
    
    
    BOOL isPhone = [JJTools valiMobile:self.phoneFleld.text];
    
    if (isPhone == NO) {
        
        [MBProgressHUD showTextMessage:@"请输入正确的手机号码!"];
        return;
    }
    
    
    timeInt = 59;
    
    sender.userInteractionEnabled = NO;
    [sender setBackgroundColor:[UIColor lightGrayColor]];
    [self.codeBtn setTitle:@"59" forState:(UIControlStateNormal)];//开启定时器大约需要1秒的时间，所以在点击的时候就开始赋值
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(CountdownWithBtn) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.time forMode:NSRunLoopCommonModes];
    
    [self requestWithCode];
    
    
}


-(void)CountdownWithBtn{
    
    timeInt--;
    
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)timeInt] forState:(UIControlStateNormal)];
    if (timeInt==0) {
        
        [self.codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        self.codeBtn.userInteractionEnabled = YES;
        [self.time invalidate];
        self.time = nil;
    }
}

-(void)requestWithCode{
    

//    NSDictionary *dic = @{@"phone":self.phoneFleld.text};
    
    [EnrollmentRequestData getCodeWithReqJson:self.phoneFleld.text succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSLog(@"验证码:%@",data);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(void)removeFromSuperview{
    
    
    [self.time invalidate];
    self.time = nil;
    
    //写在dealloc方法里面 无法释放定时器
}
-(void)dealloc{
    
    NSLog(@"释放cell");
}


#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    //    NSLog(@"==:%@",toBeString);
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position || !selectedRange)
    {
        if (toBeString.length >= 6)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:5];
            if (rangeIndex.length == 1)//判断最后一个字符长度是否为1，表情为2
            {
                textField.text = [toBeString substringToIndex:6];//截取前6位 来显示
                //                NSLog(@"1==:%@",textField.text);
                //                NSLog(@"2==:%@",[toBeString substringToIndex:6]);
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 5)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
