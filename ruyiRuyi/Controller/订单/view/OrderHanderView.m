//
//  OrderHanderView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/8.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "OrderHanderView.h"

@interface OrderHanderView()


@end
@implementation OrderHanderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUI];
    }
    
    return self;
}

-(void)layoutSubviews{
    
    
    
    
}
-(void)setUI{
    
    UIImageView *handerImg = [[UIImageView alloc] init];
    handerImg.image = [UIImage imageNamed:@"ic_ground"];
    [self addSubview:handerImg];
    
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.text = @"user";
    self.nameLab.font = [UIFont systemFontOfSize:22.f];
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.textColor = [UIColor whiteColor];
    [handerImg addSubview:self.nameLab];
    
    self.titlLab = [[UILabel alloc] init];
    self.titlLab.text = @"总订单（单）";
    self.titlLab.textAlignment = NSTextAlignmentCenter;
    self.titlLab.textColor = [UIColor whiteColor];
    [handerImg addSubview:self.titlLab];
    
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
    
    UILabel *undoneLab = [[UILabel alloc] init];
    undoneLab.text = @"未完成订单";
    undoneLab.textAlignment = NSTextAlignmentCenter;
    undoneLab.textColor = [UIColor blackColor];
    [toolView addSubview:undoneLab];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.leftBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [toolView addSubview:self.leftBtn];
    
    
    UILabel *fulfilLab = [[UILabel alloc] init];
    fulfilLab.text = @"已完成订单";
    fulfilLab.textAlignment = NSTextAlignmentCenter;
    fulfilLab.textColor = [UIColor blackColor];
    [toolView addSubview:fulfilLab];
    
    
    self.rigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rigBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.rigBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [toolView addSubview:self.rigBtn];
    
    
    [handerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(self.bounds.size.height*0.8);
        
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.and.centerX.mas_equalTo(handerImg);
        make.width.and.height.mas_equalTo(CGSizeMake(200, 40));
    }];
    
    
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
        make.bottom.mas_equalTo(self.mas_bottom).inset(10);
        
    }];
    

    [self.titlLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(10);
        make.bottom.mas_equalTo(toolView.mas_top);
        make.width.mas_equalTo(200);
        make.centerX.mas_equalTo(handerImg.mas_centerX);
    }];
    

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(toolView.mas_centerX);
        make.centerY.mas_equalTo(toolView.mas_centerY);
        make.height.mas_equalTo(toolView.mas_height).offset(-20);
        
    }];
    
    
    [undoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(toolView.mas_top);
        make.left.mas_equalTo(toolView.mas_left);
        make.right.mas_equalTo(lineView.mas_left);
        make.height.mas_equalTo(toolView.mas_height).multipliedBy(0.5);
        
    }];
    
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(toolView.mas_left);
        make.right.mas_equalTo(lineView.mas_left);
        make.top.mas_equalTo(undoneLab.mas_bottom).offset(5);
        make.bottom.mas_equalTo(toolView.mas_bottom);
    }];
    
    
    [fulfilLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(toolView.mas_top);
        make.left.mas_equalTo(lineView.mas_right);
        make.right.mas_equalTo(toolView.mas_right);
        make.height.mas_equalTo(toolView.mas_height).multipliedBy(0.5);
        
    }];
    
    
    [self.rigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(lineView.mas_right);
        make.right.mas_equalTo(toolView.mas_right);
        make.top.mas_equalTo(fulfilLab.mas_bottom).offset(5);
        make.bottom.mas_equalTo(toolView.mas_bottom);
        
    }];
    
}

-(void)setUserName:(NSString *)userName{
    
    if (userName.length<=0) {
        return;
    }
    
    self.nameLab.text = userName;
    
}

-(void)setUnfinishedNum:(NSString *)unfinishedNum{
    

    [self.leftBtn setTitle:[NSString stringWithFormat:@"%@（单）",unfinishedNum] forState:UIControlStateNormal];
}

-(void)setFinishedNum:(NSString *)finishedNum{
    
    
    [self.rigBtn setTitle:[NSString stringWithFormat:@"%@（单）",finishedNum] forState:UIControlStateNormal];
}

-(void)setTotalNum:(NSString *)totalNum{
    
    
    self.nameLab.text = totalNum;
}

@end
