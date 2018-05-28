//
//  YMCityPickerView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "YMCityPickerView.h"
#import "JJTools.h"
#import <Masonry.h>
#import "JJMacro.h"
@interface YMCityPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *copyCityArr;
}

@property(strong,nonatomic)UIPickerView *cityPickerView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIView *mainView;
@property(strong,nonatomic)UIButton *selectBtn;


@property(strong,nonatomic)NSMutableArray *provinceArr;
@property(strong,nonatomic)NSMutableArray *provinceIDs;

@property(strong,nonatomic)NSMutableArray *cityArrs;
@property(strong,nonatomic)NSMutableArray *cityIDs;


@property(strong,nonatomic)NSMutableArray *areaArr;
@property(strong,nonatomic)NSMutableArray *areaIDs;


@end
@implementation YMCityPickerView

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
        [self.mainView addSubview:self.cityPickerView];
        
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
        [self.cityPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.mas_equalTo(self.mainView.mas_leading).offset(8);
            make.trailing.mas_equalTo(self.mainView.mas_trailing).offset(-8);
            
            make.top.mas_equalTo(self.titleLab.mas_bottom);
            make.bottom.mas_equalTo(self.selectBtn.mas_top);
            
        }];
    }
    
    return self;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViewP{
    
    
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if(component == 0){
        
        if (self.provinceArr.count>0) {
            return self.provinceArr.count;
        }
        return 1;
    }
    else if (component == 1){
        
        if (self.cityArrs.count) {
            return self.cityArrs.count;
        }
        return 1;
    }
    else{
        if (self.areaArr.count) {
            return self.areaArr.count;
        }
        return 1;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0){
        
        if (self.provinceArr.count>0) {
            
            
            return self.provinceArr[row];
        }
        return @"没有数据";
    }
    else if (component == 1){
        
        if (self.cityArrs.count>0) {

            return self.cityArrs[row];
        }
        return @"没有数据";
    }else{
        
        if (self.areaArr.count>0) {
            
            return self.areaArr[row];
        }
        return @"没有数据";
        
    }
    
    return @"1";

}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    return 20.f;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        
        //在这里设置字体相关属性
        
        lbl.font = [UIFont systemFontOfSize:12.f];
        
        lbl.textColor = [UIColor blackColor];
        
        [lbl setTextAlignment:NSTextAlignmentCenter];
        
        [lbl setBackgroundColor:[UIColor clearColor]];
        
    }
    
    //重新加载lbl的文字内容
    
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return lbl;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component == 0){
      
        [self getCity:self.provinceIDs[row]];

    }
    else if (component == 1){

        [self getArea:self.cityIDs[row]];

    }
    else{
        
    }
}


#pragma mark 查询市
-(void)getCity:(NSString *)cityID{
    
    if (self.cityArrs.count>0) {
            
        [self.cityArrs removeAllObjects];
    }
    if (self.cityIDs.count>0) {
        
        [self.cityIDs removeAllObjects];
    }
    for (NSDictionary *dic1 in copyCityArr) {
            
        if ([[dic1 objectForKey:@"fid"]longLongValue] == cityID.integerValue) {
                
//            NSLog(@"市：%@",[dic1 objectForKey:@"name"]);
            [self.cityArrs addObject:[dic1 objectForKey:@"name"]];
            [self.cityIDs addObject:[dic1 objectForKey:@"id"]];
        }
    }
    [self.cityPickerView reloadComponent:1];
    [self.cityPickerView selectRow:0 inComponent:1 animated:YES];
    
    if (self.cityArrs.count>0 && self.cityIDs.count>0) {
        //查询当前显示市的区
        [self getArea:self.cityIDs[0]];
    }else{
        //台湾省香港、澳门 特殊地区没有市
        [self getArea:@"1234567890111"];
    }
}


#pragma mark 查询县
-(void)getArea:(NSString *)AreaID{
    
    if (self.areaArr.count>0) {
        
        [self.areaArr removeAllObjects];
    }
    for (NSDictionary *dic1 in copyCityArr) {
        
        if ([[dic1 objectForKey:@"fid"]longLongValue] == AreaID.integerValue) {
            
//            NSLog(@"县：%@",[dic1 objectForKey:@"name"]);
            
            [self.areaArr addObject:[dic1 objectForKey:@"name"]];
            [self.areaIDs addObject:[dic1 objectForKey:@"id"]];
        }
    }
    [self.cityPickerView reloadComponent:2];
    [self.cityPickerView selectRow:0 inComponent:2 animated:YES];
}


#define mark 首次数据加载
-(void)setCityArr:(NSArray *)cityArr{
    
    copyCityArr = cityArr;
    
    if (cityArr.count >0) {
        
        for (NSDictionary *dic  in cityArr) {
            
            if ([[dic objectForKey:@"definition"]longLongValue] == 1) {
                
//                NSLog(@"省：%@",[dic objectForKey:@"name"]);
                
                [self.provinceArr addObject:[dic objectForKey:@"name"]];
                [self.provinceIDs addObject:[dic objectForKey:@"id"]];
            }
        }
        [self.cityPickerView reloadComponent:0];
        [self.cityPickerView selectRow:0 inComponent:0 animated:YES];
        //查询当前第一个省的市
        [self getCity:self.provinceIDs[0]];
    }

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


-(void)selectCity:(UIButton *)sender{
    
    if (copyCityArr.count>1) {
        
        NSInteger row=[self.cityPickerView selectedRowInComponent:0];
        NSString *provinceStr=[self.provinceArr objectAtIndex:row];
        
        
        NSInteger row1=[self.cityPickerView selectedRowInComponent:1];
        NSString *cityStr;
        NSString *cityID;
        if (self.cityArrs.count>0) {
            cityStr=[self.cityArrs objectAtIndex:row1];
            cityID = [self.cityIDs objectAtIndex:row1];
        }else{
            cityStr= @"";
            cityID = @"";
        }

        NSInteger row2=[self.cityPickerView selectedRowInComponent:2];

        NSString *areaStr;
        NSString *areaID;
        if (self.areaArr.count>0) {
            
            areaStr=[self.areaArr objectAtIndex:row2];
            areaID = [self.areaIDs objectAtIndex:row2];
        }else{
            
            areaStr = @"";
            areaID = @"";
        }
        self.cityBlcok(provinceStr, cityStr, areaStr, cityID, areaID);
        
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
-(UIPickerView *)cityPickerView{
    
    if (!_cityPickerView) {
        
        _cityPickerView = [[UIPickerView alloc] init];
        _cityPickerView.backgroundColor = [UIColor whiteColor];
        _cityPickerView.delegate = self;
    }
    
    
    return _cityPickerView;
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
-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"请选择门店城市";
        _titleLab.font = [UIFont systemFontOfSize:16.f];
    }
    return _titleLab;
}

-(NSMutableArray *)provinceIDs{
    
    if (!_provinceIDs) {
        
        _provinceIDs = [NSMutableArray array];
    }
    return _provinceIDs;
}
-(NSMutableArray *)provinceArr{
    
    if (!_provinceArr) {
        
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}

-(NSMutableArray *)cityArrs{
    
    if (!_cityArrs) {
        
        _cityArrs = [NSMutableArray array];
    }
    return _cityArrs;
}
-(NSMutableArray *)cityIDs{
    
    if (!_cityIDs) {
        
        _cityIDs = [NSMutableArray array];
    }
    return _cityIDs;
}

-(NSMutableArray *)areaArr{
    
    if (!_areaArr) {
        
        _areaArr = [NSMutableArray array];
    }
    
    
    return _areaArr;
}

-(NSMutableArray *)areaIDs{
    
    if (!_areaIDs) {
        
        _areaIDs = [NSMutableArray array];
    }
    
    
    return _areaIDs;
}
@end
