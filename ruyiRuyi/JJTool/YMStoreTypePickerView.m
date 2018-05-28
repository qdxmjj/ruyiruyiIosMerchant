//
//  YMStoreTypePickerView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "YMStoreTypePickerView.h"
#import "JJTools.h"
#import <Masonry.h>
#import "JJMacro.h"
@interface YMStoreTypePickerView()

@property(strong,nonatomic)UIPickerView *storeTypePicker;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIView *mainView;
@property(strong,nonatomic)UIButton *selectBtn;
@end

@implementation YMStoreTypePickerView



-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        
//        //点击背景是否影藏
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//        [self addGestureRecognizer:tap];
//        
        
        
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.titleLab];
        [self.mainView addSubview:self.selectBtn];
        [self.mainView addSubview:self.storeTypePicker];
        
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
        [self.storeTypePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            
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
    
    if (self.typeArr) {
        return self.typeArr.count;
    }
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
    return [[self.typeArr objectAtIndex:row] objectForKey:@"name"];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    return 20.f;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
 
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

-(void)selectStoreType:(UIButton *)sender{
    
    
    if (self.typeArr.count>1) {
        
        NSInteger row=[self.storeTypePicker selectedRowInComponent:0];

        NSString *sotreType=[[self.typeArr objectAtIndex:row] objectForKey:@"name"];
        NSString *typeID=[[self.typeArr objectAtIndex:row] objectForKey:@"id"];

        self.storeType(sotreType,typeID);
    }

    [self dismiss];
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
-(UIPickerView *)storeTypePicker{
    
    if (!_storeTypePicker) {
        
        _storeTypePicker = [[UIPickerView alloc] init];
        _storeTypePicker.backgroundColor = [UIColor whiteColor];
        _storeTypePicker.delegate = self;
    }
    
    
    return _storeTypePicker;
}
-(UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:[JJTools getColor:@"#FF6623"]];
        [_selectBtn addTarget:self action:@selector(selectStoreType:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _selectBtn;
}
-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"请选择门店类别";
        _titleLab.font = [UIFont systemFontOfSize:16.f];
    }
    return _titleLab;
}
@end
