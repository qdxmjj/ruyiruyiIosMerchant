//
//  IncomeDatePickerView.m
//  ruyiRuyi
//
//  Created by 姚永敏 on 2018/10/9.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "IncomeDatePickerView.h"
#import <Masonry.h>
#import "JJTools.h"
@interface IncomeDatePickerView ()<UIPickerViewDelegate>

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UIPickerView *dataPickerView;

@property(strong,nonatomic)UIButton *selectBtn;

@property (nonatomic, assign)NSInteger year;

@property (nonatomic, assign)NSInteger month;

@property (nonatomic, assign)NSInteger day;

@property (nonatomic,assign)NSInteger selectYear;

@end

@implementation IncomeDatePickerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3f];
        
        NSDate  *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        _year=[components year];
        _month=[components month];
        _day=[components day];
     
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.selectBtn];
        [self.mainView addSubview:self.dataPickerView];

        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.and.height.mas_equalTo(CGSizeMake(self.frame.size.width-20,(self.frame.size.width-20)*0.7));
        }];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(self.mainView.mas_bottom);
            make.leading.mas_equalTo(self.mainView.mas_leading);
            make.trailing.mas_equalTo(self.mainView.mas_trailing);
            make.height.mas_equalTo(40);
        }];
        
        [self.dataPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
           
//            make.edges.mas_equalTo(self.mainView);
            make.top.mas_equalTo(self.mainView.mas_top);
            make.left.and.right.mas_equalTo(self.mainView);
            make.bottom.mas_equalTo(self.selectBtn.mas_top);
        }];
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViewP{
    
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            
            return 10;
            break;
        case 1:
            
            if (self.selectYear != self.year && self.selectYear != 0) {

                return 12;
            }
            if (_month < 12) {
                
                return _month;
            }
            return 12;
            break;
            
        default:
            
            return 0;
            break;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30.f;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            
            self.selectYear = self.year-row;
            [pickerView reloadComponent:1];
            break;
        case 1:
        default:
            break;
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        lbl.font = [UIFont systemFontOfSize:18.f];
        lbl.textColor = [UIColor blackColor];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setBackgroundColor:[UIColor clearColor]];
    }
    
    //重新加载lbl的文字内容
    if (component == 0) {
        
        lbl.text = [NSString stringWithFormat:@"%ld",_year-row];
    }else if (component == 1){
        
        if (self.selectYear != self.year && self.selectYear != 0) {
            
            if (12-row<10) {
                
                lbl.text = [NSString stringWithFormat:@"0%ld",12-row];
            }else{
                lbl.text = [NSString stringWithFormat:@"%ld",12-row];
            }
        }else{
            if (_month-row<10) {
                
                lbl.text = [NSString stringWithFormat:@"0%ld",_month-row];
            }else{
                lbl.text = [NSString stringWithFormat:@"%ld",_month-row];
            }
        }
    }else{
        
        lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    return lbl;
}

-(void)selectCity:(UIButton *)sender{
    
    NSInteger yearInteger = [self.dataPickerView selectedRowInComponent:0];
    
    NSInteger monthInteger = [self.dataPickerView selectedRowInComponent:1];
    
    NSString *yearStr = [NSString stringWithFormat:@"%ld",self.year-yearInteger];
    
    NSString *monthStr;

    //当前年 月份可能不够12个月 用当前月 减掉 选择的row  非当前年 12个月 用12来减
    if (self.selectYear != self.year && self.selectYear != 0) {

        if (12-monthInteger<10) {

            monthStr  = [NSString stringWithFormat:@"0%ld",12-monthInteger];
        }else{
            monthStr  = [NSString stringWithFormat:@"%ld",12-monthInteger];
        }
    }else{
    
        if (_month-monthInteger<10) {
            
            monthStr  = [NSString stringWithFormat:@"0%ld",self.month-monthInteger];
        }else{
            monthStr  = [NSString stringWithFormat:@"%ld",self.month-monthInteger];
        }
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(selectDateWithYear:month:)]) {
     
        [self.delegate selectDateWithYear:yearStr month:monthStr];
    }
    [self dismiss];
}

#pragma mark - Action
-(void)showWithSuperView:(UIView *)view{
    if (!view) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }else{
        [view addSubview:self];
    }

    self.mainView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
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

-(UIView *)mainView{
    
    if (!_mainView) {
        
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

-(UIPickerView *)dataPickerView{
    
    if (!_dataPickerView) {
        
        _dataPickerView = [[UIPickerView alloc] init];
        _dataPickerView.delegate = self;
        [_dataPickerView selectRow:0 inComponent:0 animated:NO];
        [_dataPickerView selectRow:0 inComponent:1 animated:NO];
    }
    return _dataPickerView;
}
-(UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[JJTools getColor:@"#FF6623"]];
        [_selectBtn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
@end
