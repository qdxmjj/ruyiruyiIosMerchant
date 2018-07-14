//
//  YMCommodityTypePickerView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/17.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "YMCommodityTypePickerView.h"
#import <Masonry.h>
#import "JJTools.h"
@interface YMCommodityTypePickerView()<UIPickerViewDelegate>
{
    NSArray *selectArr;
    
}

@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIView *mainView;
@property(strong,nonatomic)UIButton *selectBtn;
@property(nonatomic,strong)UIPickerView *pView;

@property(nonatomic,strong)UIView *toolView;

@property(nonatomic,strong)NSMutableArray *serviceArr;//大类服务

@property(nonatomic,strong)NSMutableArray *subServiceArr;//大类服务的子服务

@property(nonatomic,strong)NSMutableArray *serviceTypeID;//大类服务的ID

@property(nonatomic,strong)NSMutableArray *serviceID;//子服务的ID

@end

@implementation YMCommodityTypePickerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];

        [self addSubview:self.mainView];
        [self.mainView addSubview:self.titleLab];
        [self.mainView addSubview:self.selectBtn];
        [self.mainView addSubview:self.pView];


        
        
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.and.height.mas_equalTo(CGSizeMake(self.frame.size.width-20,(self.frame.size.width-20)*0.7));
            
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

        [self.pView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.mas_equalTo(self.mainView.mas_leading).offset(8);
            make.trailing.mas_equalTo(self.mainView.mas_trailing).offset(-8);
            
            make.top.mas_equalTo(self.titleLab.mas_bottom);
            make.bottom.mas_equalTo(self.selectBtn.mas_top);
            
        }];
    }

    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViewP{
    
    
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if(component == 0){
        if (self.serviceArr.count>0) {
            return self.serviceArr.count;
        }
        return 1;
    }
    else{
        if (selectArr.count>0) {
            return [selectArr count];
        }
        return 1;
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    if(component == 0){
     
        if (self.serviceArr.count>0) {
            
            
            return self.serviceArr[row];
        }
        
        return @"没有数据";
    }else{
        
        if (selectArr.count>0) {
            
            
            return selectArr[row];
        }
        return @"没有数据";

    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    
    return 40.f;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        
        //在这里设置字体相关属性
        
        lbl.font = [UIFont systemFontOfSize:18.f];
        
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
        
        if ([self.subServiceArr[row] count]>0) {
            selectArr = self.subServiceArr[row];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
    }
}

-(void)setDataDic:(NSDictionary *)dataDic{
    
    if (dataDic.count>0) {
        //大类服务内容
        [self.serviceArr addObject:@"全部商品"];
        [self.serviceArr addObjectsFromArray:[dataDic allKeys]];

        //每个value 都是一个数组 数组套数组  子服务内容
        [self.subServiceArr addObjectsFromArray:[[dataDic allValues] valueForKeyPath:@"serviceName"]];
        [self.subServiceArr insertObject:@[@"全部商品"] atIndex:0];
        
        //子服务ID
        [self.serviceID addObjectsFromArray:[[dataDic allValues] valueForKeyPath:@"serviceId"]];
        [self.serviceID insertObject:@[@""] atIndex:0];

        
        //大类服务ID
        [self.serviceTypeID addObjectsFromArray:[[dataDic allValues] valueForKeyPath:@"serviceTypeId"]];
        [self.serviceTypeID insertObject:@[@""] atIndex:0];
        
        
        //默认选中第一行
        selectArr = self.subServiceArr[0];
        [self.pView reloadComponent:0];
        [self.pView selectRow:0 inComponent:0 animated:YES];
        
    }
    

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
-(void)selectCity:(UIButton *)sender{

    if (self.serviceID.count<=0||self.serviceTypeID.count<=0||self.serviceArr.count<=0||selectArr.count<=0) {
        
        self.disBlock(nil, nil, nil, YES);

        [self dismiss];        
        return;
    }
    
    NSInteger row = [self.pView selectedRowInComponent:0];
    NSString *serviceStr= self.serviceArr[row];
    
    NSInteger row1 = [self.pView selectedRowInComponent:1];
    NSString *subServiceStr = selectArr[row1];
    
    NSString *serviceID = self.serviceID[row][row1];
    NSString *subSerViceID = self.serviceTypeID[row][row1];
    
    self.disBlock([NSString stringWithFormat:@"%@ %@",serviceStr,subServiceStr], subSerViceID, serviceID, YES);
    
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





-(NSMutableArray *)serviceArr{
    
    if (!_serviceArr) {
        
        _serviceArr = [NSMutableArray array];
    }
    
    
    return _serviceArr;
}
-(NSMutableArray *)subServiceArr{
    
    if (!_subServiceArr) {
        
        _subServiceArr = [NSMutableArray array];
    }
    
    
    return _subServiceArr;
}

-(NSMutableArray *)serviceTypeID{
    
    if (!_serviceTypeID) {
        
        _serviceTypeID = [NSMutableArray array];
    }
    
    
    return _serviceTypeID;
}

-(NSMutableArray *)serviceID{
    
    if (!_serviceID) {
        
        _serviceID = [NSMutableArray array];
    }
    
    
    return _serviceID;
}

-(UIView *)mainView{
    
    if (!_mainView) {
        
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    
    
    return _mainView;
}
-(UIPickerView *)pView{
    
    if (!_pView) {
        
        _pView = [[UIPickerView alloc] init];
        _pView.backgroundColor = [UIColor whiteColor];
        _pView.delegate = self;
    }
    
    
    return _pView;
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
        _titleLab.text = @"请选择服务类型";
        _titleLab.font = [UIFont systemFontOfSize:16.f];
    }
    return _titleLab;
}
@end
