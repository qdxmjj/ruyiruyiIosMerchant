//
//  YMStoreStatusPickerView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/21.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "YMStoreStatusPickerView.h"
#import "JJTools.h"
#import <Masonry.h>
#import "JJMacro.h"

@interface YMStoreStatusPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *copyCityArr;
}

@property(strong,nonatomic)UIPickerView *statusPickerView;

@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIView *mainView;
@property(strong,nonatomic)UIButton *selectBtn;
@end


@implementation YMStoreStatusPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        
        
        //点击背景是否影藏
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        //        [self addGestureRecognizer:tap];
        
        
        
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.titleLab];
        [self.mainView addSubview:self.selectBtn];
        [self.mainView addSubview:self.statusPickerView];
        
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.and.height.mas_equalTo(CGSizeMake(343,234));
            
        }];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.mainView.mas_top).offset(8);
            make.leading.mas_equalTo(self.mainView.mas_leading).offset(8);
            make.trailing.mas_equalTo(self.mainView.mas_trailing);
            make.height.mas_equalTo(20);
        }];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(self.mainView.mas_bottom);
            make.leading.mas_equalTo(self.mainView.mas_leading);
            make.trailing.mas_equalTo(self.mainView.mas_trailing);
            make.height.mas_equalTo(40);
        }];
        [self.statusPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.mas_equalTo(self.mainView.mas_leading).offset(8);
            make.trailing.mas_equalTo(self.mainView.mas_trailing).offset(-8);
            
            make.top.mas_equalTo(self.titleLab.mas_bottom);
            make.bottom.mas_equalTo(self.selectBtn.mas_top);
            
        }];
    }
    
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViewP{
    
    
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
  
    switch (row) {
        case 0:
            
            return @"在售";
            break;
        case 1:
            
            return @"已下架";
            break;
            
        default:
            break;
    }
    
    return @"";
}

-(void)selectCity{
    
    NSInteger row=[self.statusPickerView selectedRowInComponent:0];

    
    self.statusBlcok(row==0?@"1":@"2", row==0?@"在售":@"已下架");
    
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
-(UIPickerView *)statusPickerView{
    
    if (!_statusPickerView) {
        
        _statusPickerView = [[UIPickerView alloc] init];
        _statusPickerView.backgroundColor = [UIColor whiteColor];
        _statusPickerView.delegate = self;
    }
    
    
    return _statusPickerView;
}
-(UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[JJTools getColor:@"#FF6623"]];
        [_selectBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    return _selectBtn;
}
-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"请选择商品状态";
        _titleLab.font = [UIFont systemFontOfSize:16.f];
    }
    return _titleLab;
}
@end
