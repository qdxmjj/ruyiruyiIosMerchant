//
//  YMDatePickerView.m
//  YMDatePickerView
//
//  Created by 小马驾驾 on 2018/4/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "YMDatePickerView.h"
#import "JJMacro.h"


@interface YMDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSArray *timeArr;
}

@end

@implementation YMDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGFloat)height {
    return self.frame.size.height;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        //点击背景是否影藏
        
        self.bottomConstraint.constant = -self.height;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        //        tap.delegate = self;
//        [self addGestureRecognizer:tap];
        
        [self layoutIfNeeded];

//        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];

        
        self.startPickerView.delegate = self;
        self.stopPickerView.delegate = self;
        timeArr = @[@"01:00:00",@"02:00:00",@"03:00:00",@"04:00:00",@"05:00:00",@"06:00:00",@"07:00:00",@"08:00:00",@"09:00:00",@"10:00:00",@"11:00:00",@"12:00:00",@"13:00:00",@"14:00:00",@"15:00:00",@"16:00:00",@"17:00:00",@"18:00:00",@"19:00:00",@"20:00:00",@"21:00:00",@"22:00:00",@"23:00:00",@"24:00:00"];
        
        [self.startPickerView selectRow:6 inComponent:0 animated:NO];
        [self.stopPickerView selectRow:6 inComponent:0 animated:NO];

    }
    
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame{
//
//    self = [super initWithFrame:frame];
//
//    if (self) {
//
//    }
//
//
//    return self;
//}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViewP{
    
    
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (timeArr) {
        return timeArr.count;
    }
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
    return [timeArr objectAtIndex:row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    return 20.f;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    if (pickerView == self.startPickerView) {
        [self.stopPickerView selectRow:row inComponent:0 animated:YES];
    }
}
- (IBAction)selelctTime:(UIButton *)sender {
    
    NSInteger startRow=[self.startPickerView selectedRowInComponent:0];
    NSString *starTime= [timeArr objectAtIndex:startRow];
    
    
    NSInteger stopRow=[self.stopPickerView selectedRowInComponent:0];
    NSString *stopTime=[timeArr objectAtIndex:stopRow];
    
    if (starTime.length>0&&stopTime.length>0) {
        self.selectTime(starTime, stopTime);
    }
    
    [self dismiss];
    
}


#pragma mark - Action
-(void)show {
    
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
//        self.bottomConstraint.constant = -self.height;
//        self.backgroundColor = RGBA(0, 0, 0, 0);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}
@end
