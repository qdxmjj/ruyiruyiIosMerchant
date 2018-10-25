//
//  RecordingDetailsView.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/19.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "RecordingDetailsView.h"
#import <Masonry.h>
#import "JJMacro.h"
@interface RecordingDetailsView ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIImageView *payImgView;
@property (weak, nonatomic) IBOutlet UILabel *payNameLab;
@property (weak, nonatomic) IBOutlet UILabel *WithdrawalAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *WithdrawalStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *receiptInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;

@end

@implementation RecordingDetailsView

-(instancetype)init{
    
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
      
    }
    return self;
}

-(void)layoutSubviews{
    
    if ([self.isPayStatus isEqualToString:@"1"]) {
        self.payImgView.image = [UIImage imageNamed:@"ic_pay"];
        self.payNameLab.text = @"支付宝提现";
    }else{
        self.payImgView.image = [UIImage imageNamed:@"ic_wechat"];
        self.payNameLab.text = @"微信提现";
    }
    
    self.WithdrawalAmountLab.text = [NSString stringWithFormat:@"%@ 元",self.withdrawAmount];
    
    NSString *statusStr  = [self.withdrawStatus integerValue] == 1?@"提现中":[self.withdrawStatus integerValue] == 2?@"提现成功":@"提现失败";

    self.WithdrawalStatusLab.text = statusStr;
    self.receiptInfoLab.text = self.receiptInfo;
    self.dateLab.text = self.date;
    self.orderNoLab.text = self.orderNO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismiss];
}


#pragma mark - Action
-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    self.mainView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        self.mainView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
}

-(void)dismiss {
    
    [UIView animateWithDuration:.3 animations:^{
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

@end
