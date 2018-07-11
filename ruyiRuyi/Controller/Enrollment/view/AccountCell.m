//
//  AccountCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "AccountCell.h"
#import "JJMacro.h"
#import "EnrollmentRequestData.h"
@interface AccountCell()
{
    NSInteger timeInt;
}

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property(nonatomic,strong)NSTimer *time;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@end

@implementation AccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification" object:self.codeTextField];
    

}


#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    JJWeakSelf
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

                NSString *value = [NSString stringWithFormat:@"{\"phone\":\"%@\",\"code\":\"%@\"}",self.phoenField.text,[toBeString substringToIndex:6]];
                
                [JJRequest postRequest:@"verificationCode" params:@{@"reqJson":value} success:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
                
                    NSLog(@"返回码：%@  msg:%@ DATA:%@",code,message,data);
                    if ([code longLongValue] == 1) {
                
                        weakSelf.codeImage.image = [UIImage imageNamed:@"ic_check"];
                
                    }else if([code longLongValue] == 111111){
                        
                        [MBProgressHUD showTextMessage:@"此手机号码已被注册！"];
                        
                        return ;
                    }else{
                        
                        weakSelf.codeImage.image = [UIImage imageNamed:@"ic_wrong"];
                    }
                
                } failure:^(NSError * _Nullable error) {
                    weakSelf.codeImage.image = [UIImage imageNamed:@"ic_wrong"];
                }];
                
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 5)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
}
- (IBAction)BtnCode:(UIButton *)sender {
    
    BOOL isPhone = [JJTools valiMobile:self.phoenField.text];
    
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
        [self.codeBtn setBackgroundColor:[JJTools getColor:@"#FF6623"]];
        self.codeBtn.userInteractionEnabled = YES;
        [self.time invalidate];
        self.time = nil;
    }
}

-(void)requestWithCode{
    
    
    [EnrollmentRequestData getCodeWithReqJson:self.phoenField.text succrss:^(NSString * _Nullable code, NSString * _Nullable message, id  _Nullable data) {
        
        NSLog(@"验证码:%@",data);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)removeFromSuperview{
    
    
    [self.time invalidate];
    self.time = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:self.codeTextField];
    //写在dealloc方法里面 无法释放定时器
}
-(void)dealloc{

    NSLog(@"释放cell");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
