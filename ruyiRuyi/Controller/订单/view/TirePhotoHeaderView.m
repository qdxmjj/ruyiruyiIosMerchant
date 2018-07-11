//
//  TirePhotoHeaderView.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "TirePhotoHeaderView.h"
#import "JJMacro.h"
#import <Masonry.h>
@implementation TirePhotoHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH/2, 40)];
        leftLab.text = @"轮胎照片";
        leftLab.textAlignment = NSTextAlignmentLeft;
        leftLab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:leftLab];
        

        _exampleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_exampleBtn setTitle:@"拍照示例" forState:UIControlStateNormal];
        [_exampleBtn setTitleColor:JJFirstLevelFont forState:UIControlStateNormal];
        [_exampleBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_exampleBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        _exampleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _exampleBtn.layer.borderWidth = 1.f;
        _exampleBtn.layer.cornerRadius = 3.f;
        _exampleBtn.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_exampleBtn];
        
        [_exampleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).inset(16);
            make.width.and.height.mas_equalTo(CGSizeMake(80, 30));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}


@end
