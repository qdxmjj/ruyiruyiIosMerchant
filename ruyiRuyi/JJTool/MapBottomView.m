//
//  MapBottomView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/2.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "MapBottomView.h"

@implementation MapBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
    
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOpacity = 1;//阴影透明度
        self.layer.shadowOffset = CGSizeMake(0, 0);//设置偏移量
        [self initUI];
        
    }
    return self;
}

-(void)initUI{
    
    self.titleLab = [[UILabel alloc] init];
    [self addSubview:self.titleLab];
    
    self.subTitleLab = [[UILabel alloc]init];
    self.subTitleLab.textColor = [UIColor lightGrayColor];
    [self addSubview:self.subTitleLab];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setBackgroundColor:[JJTools getColor:@"#FF6623"]];
    [self.btn setTitle:@"确认选择" forState:UIControlStateNormal];
    self.btn.layer.cornerRadius = 3.0;
    [self addSubview:self.btn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.mas_leading).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.and.height.mas_equalTo(CGSizeMake(200, 25));
    }];
    
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLab.mas_leading);
        make.top.mas_equalTo(self.titleLab.mas_bottom);
        make.width.and.height.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.mas_leading).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-10);
        make.height.mas_equalTo(40);
    }];
}
@end
