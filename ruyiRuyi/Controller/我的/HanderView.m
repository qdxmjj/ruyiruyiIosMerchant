//
//  HanderView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/7.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "HanderView.h"
@interface HanderView()

@property(nonatomic,strong)UIImageView *subImg;
@property(nonatomic,strong)UILabel *nameLab;

@end

@implementation HanderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUI];
    }
    
    return self;
}
-(void)setUI{
    
    UIImageView *handerImg = [[UIImageView alloc] init];
    handerImg.image = [UIImage imageNamed:@"ic_ground"];
    [self addSubview:handerImg];
    
    self.subImg = [[UIImageView alloc] init];
    self.subImg.backgroundColor = [UIColor lightGrayColor];
    self.subImg.layer.cornerRadius = 50;
    self.subImg.layer.masksToBounds =YES;
    [handerImg addSubview:self.subImg];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.text = @"user";
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.textColor = [UIColor whiteColor];
    [handerImg addSubview:self.nameLab];
    
    
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = [UIColor whiteColor];
    toolView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    toolView.layer.shadowOpacity = 0.8;
    toolView.layer.shadowOffset = CGSizeMake(0, 0);
    toolView.layer.cornerRadius = 5;
    [self addSubview:toolView];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [toolView addSubview:lineView];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setTitle:@"我的订单" forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"ic_dingdan"] forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
    [toolView addSubview:self.leftBtn];
    
    
    self.rigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rigBtn setTitle:@"管理店铺" forState:UIControlStateNormal];
    [self.rigBtn setImage:[UIImage imageNamed:@"ic_shop"] forState:UIControlStateNormal];
    [self.rigBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.rigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rigBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
    [toolView addSubview:self.rigBtn];
    
    
    [handerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(self.bounds.size.height*0.8);
        
    }];
    
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(toolView.mas_top).inset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(@20);
    }];
    
    [self.subImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.and.height.mas_equalTo(CGSizeMake(100, 100));
        make.bottom.mas_equalTo(self.nameLab.mas_top).inset(5);
        make.centerX.mas_equalTo(handerImg.mas_centerX);
        
    }];
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(toolView.mas_centerX);
        make.centerY.mas_equalTo(toolView.mas_centerY);
        make.height.mas_equalTo(toolView.mas_height).offset(-20);
        
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(toolView.mas_left);
        make.right.mas_equalTo(lineView.mas_left);
        make.top.and.bottom.mas_equalTo(toolView);
    }];
    
    [self.rigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(lineView.mas_right);
        make.right.mas_equalTo(toolView.mas_right);
        make.top.and.bottom.mas_equalTo(toolView);
        
    }];
    
}

-(void)setUserName:(NSString *)userName{
    
    if (userName.length<=0) {
        return;
    }
    
    self.nameLab.text = userName;
    
}

-(void)setAvatar:(NSString *)Avatar{
    
    if (Avatar.length<=0) {
        return;
    }
    
    [self.subImg sd_setImageWithURL:[NSURL URLWithString:Avatar]];
}
@end
