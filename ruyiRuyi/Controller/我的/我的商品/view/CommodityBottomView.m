//
//  CommodityBottomView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/5/15.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "CommodityBottomView.h"
#import <Masonry.h>

@interface CommodityBottomView()


@property(nonatomic,strong)UIView *rightView;


@property(nonatomic,strong)UILabel *classLab;


@end

@implementation CommodityBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.addBtn];
        [self addSubview:self.rightView];
        [self.rightView addSubview:self.btn];
        [self.rightView addSubview:self.classLab];
        [self.rightView addSubview:self.imgV];
        
//        [self setUI];

    }
    return self;
}

-(void)layoutSubviews{
    
    
    [self setUI];
    
}
-(void)setUI{

    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.left.mas_equalTo(self.mas_left);
    }];
    
  
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.right.mas_equalTo(self.mas_right);
    }];
    
   
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.center.mas_equalTo(self.rightView);
        make.width.mas_equalTo(self.rightView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(self.rightView.mas_height);
    }];
    
    
   
    [self.classLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.rightView.mas_left).inset(5);
        make.right.mas_equalTo(self.btn.mas_left).inset(5);
        make.centerY.mas_equalTo(self.rightView.mas_centerY);
        make.height.mas_equalTo(self.rightView.mas_height);
    }];
    
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.rightView.mas_right).inset(5);
        make.left.mas_equalTo(self.btn.mas_right).inset(5);
        make.centerY.mas_equalTo(self.rightView.mas_centerY);
        make.height.mas_equalTo(self.rightView.mas_height);
        
    }];
}

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"添加商品" forState:UIControlStateNormal];
        [_addBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_addBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    return _addBtn;
}

-(UIView *)rightView{
    
    if (!_rightView) {
        
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor colorWithRed:255.f/255 green:102.f/255 blue:35.f/255 alpha:1.f];
    }
    return _rightView;
}


-(UIButton *)btn{
    
    if (!_btn) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"全部分类" forState:UIControlStateNormal];
        [_btn.titleLabel setTextColor:[UIColor whiteColor]];
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _btn;
}

-(UILabel *)classLab{
    
    if (!_classLab) {
        
        _classLab = [[UILabel alloc] init];
        _classLab.text = @"分类";
        _classLab.font = [UIFont systemFontOfSize:14.0f];
        _classLab.textColor = [UIColor whiteColor];
    }
    return _classLab;
}

-(UIImageView *)imgV{
    
    if (!_imgV) {
        
        _imgV = [[UIImageView alloc] init];
        _imgV.image = [UIImage imageNamed:@"ic_back"];
        _imgV.contentMode = UIViewContentModeCenter;
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2+M_PI);
        
        _imgV.transform = transform;
    }

    return _imgV;
}
@end
